import 'dart:async';

class Router {
    List<String> routes = new List();
    StreamController dataStreamController = new StreamController<String>();

    Stream<String> get onRouteChange => dataStreamController.stream;

    init() {}

    pushRoute(String route) {
        routes.add(route);
        dataStreamController.add(route);
    }
}