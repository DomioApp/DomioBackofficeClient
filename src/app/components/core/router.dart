import 'dart:async';

class Router {
    List<String> routes = new List();
    StreamController routeStreamController = new StreamController<String>();

    Stream<String> get onRouteChange => routeStreamController.stream;

    init() {}

    pushRoute(String route) {
        routes.add(route);
        routeStreamController.add(route);
    }
}