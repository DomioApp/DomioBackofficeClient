import '../core/requests.dart';

class Payload<T> {
    Requests endpoint;
    String response;
    T data;

    Payload(Requests endpointInstance, T data) {
        endpoint = endpointInstance;
        this.data = data;
    }
}