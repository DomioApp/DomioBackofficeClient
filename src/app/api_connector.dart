import 'dart:html';
import 'dart:convert' show JSON;
import './config.dart';

enum Endpoints {
    Login
}

void onDataLoaded(String resp) {
//    Map decoded = JSON.decode(resp);
}

class Token {
    String email;
    String token;
    String id;

    Token.fromJsonString(String jsonString) {
        var resp = JSON.decode(jsonString);

        email = resp['email'];
        token = resp['token'];
        id = resp['id'];

        if (email == null || token == null || id == null) {
            throw new StateError('one of fields is empty');
        }
    }
}

postRequest(String url, model) async {
    HttpRequest request = new HttpRequest();

    request.withCredentials = true;


    var fullUrl = '${apiUrl}${url}';

    request.open("POST", fullUrl);

    request.setRequestHeader('Content-Type', 'application/json');


    if (window.localStorage['token'] != null) {
        request.setRequestHeader(
            'Authorization', 'Bearer ${window.localStorage['token']}');
    }


    String jsonData = JSON.encode(model);

    request.send(jsonData);

    await request.onLoadEnd.first;

    return request;
}

putRequest(String url, model) async {
    HttpRequest request = new HttpRequest();

    request.withCredentials = true;


    var fullUrl = '${apiUrl}${url}';

    request.open('PUT', fullUrl);

    request.setRequestHeader('Content-Type', 'application/json');

    var token = readCookie('token');

    if (token != null) {
        request.setRequestHeader('Authorization', 'Bearer $token');
    }


    String jsonData = JSON.encode(model);

    request.send(jsonData);

    await request.onLoadEnd.first;

    return request;
}

deleteRequest(String url, model) async {
    HttpRequest request = new HttpRequest();

    request.withCredentials = true;


    var fullUrl = '${apiUrl}${url}';

    request.open("DELETE", fullUrl);

    request.setRequestHeader('Content-Type', 'application/json');


    if (window.localStorage['token'] != null) {
        request.setRequestHeader(
            'Authorization', 'Bearer ${window.localStorage['token']}');
    }


    String jsonData = JSON.encode(model);

    request.send(jsonData);


    await request.onLoadEnd.first;

    return request;
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