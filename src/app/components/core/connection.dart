import 'dart:html';
import 'dart:async';
import '../../config.dart';

enum Requests {
    GetUsers,
    GetPendingDomains
}

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
    StreamController usersDataStreamController = new StreamController<String>();
    StreamController pendingDomainsDataStreamController = new StreamController<String>();

    Stream<String> get onUsersData => usersDataStreamController.stream;

    Stream<String> get onPendingDomainsData => pendingDomainsDataStreamController.stream;

    sendRequest(Requests endpoint) {
        HttpRequest request = new HttpRequest();

        request.withCredentials = true;


        print(endpoint);

        var fullUrl = '${apiUrl}${endpoint.toString()}';

        request.open('GET', fullUrl);

        request.setRequestHeader('Content-Type', 'application/json');


        if (window.localStorage['token'] != null) {
            request.setRequestHeader('Authorization', 'Bearer ${window.localStorage['token']}');
        }

        request.onLoadEnd.listen((_) => print(request.responseText));

        request.send();
    }

    getRequestWithData(Requests endpoint, dataToSend, StreamController streamController) async {
        HttpRequest request = new HttpRequest();

        request.withCredentials = true;


        print(endpoint);

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