import 'dart:convert';

import '../core/requests.dart';

class Payload {
    Requests endpoint;
    String response;
    List data;

    Payload(Requests endpointInstance, String responseText) {
        endpoint = endpointInstance;
        response = responseText;
        data = JSON.decode(response);
    }
}