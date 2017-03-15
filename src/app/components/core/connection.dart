import 'dart:html';
import 'dart:async';
import 'dart:convert';

import '../../config.dart';
import '../model/payload.dart';
import 'requests.dart';

String readCookie(String name) {
    String nameEQ = name + '=';
    List<String> ca = document.cookie.split(';');
    for (int i = 0; i < ca.length; i++) {
        String c = ca[i];
        c = c.trim();
        if (c.indexOf(nameEQ) == 0) {
            return c.substring(nameEQ.length);
        }
    }

    return null;
}

class Connection {
    StreamController dataStreamController = new StreamController<Payload>();

    Stream<Payload> get onData => dataStreamController.stream;

    sendRequest(Requests endpoint) {
        String url = getUrl(endpoint);

        HttpRequest request = new HttpRequest();

        request.withCredentials = true;


        var fullUrl = '${apiUrl}${url}';

        request.open('GET', fullUrl);

        request.setRequestHeader('Content-Type', 'application/json');


        if (window.localStorage['token'] != null) {
            request.setRequestHeader('Authorization', 'Bearer ${window.localStorage['token']}');
        }

        request.onLoadEnd.listen((_) => dataStreamController.add(new Payload(endpoint, request.responseText)));

        request.send();
    }

    String getUrl(Requests endpoint) {
        String url = null;
        if (endpoint == Requests.FetchUsers) {
            url = '/users';
        } else if (endpoint == Requests.FetchPendingDomains) {
            url = '/domains/pending';
        }
        else {
            throw('Endpoint must be defined.');
        }

        return url;
    }

    getRequestWithData(Requests endpoint, dataToSend, StreamController streamController) async {
        HttpRequest request = new HttpRequest();

        request.withCredentials = true;


        var fullUrl = '${apiUrl}${endpoint.toString()}';

        request.open('GET', fullUrl);

        request.setRequestHeader('Content-Type', 'application/json');


        if (window.localStorage['token'] != null) {
            request.setRequestHeader('Authorization', 'Bearer ${window.localStorage['token']}');
        }


        String jsonData = JSON.encode(dataToSend);


        request.onLoadEnd.listen((ProgressEvent event) => streamController.add(request.responseText));

        request.send(jsonData);
    }
}