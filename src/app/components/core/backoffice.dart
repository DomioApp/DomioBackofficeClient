import 'dart:html';
import 'dart:async';

import 'connection.dart';
import 'router.dart';

import '../ui/top_bar.dart';
import '../ui/sub_bar.dart';
import '../ui/users_area.dart';

class Backoffice {
    DivElement mainArea;
    TopBar topBar = new TopBar('.b-app-container > .b-top-bar-container');
    SubBar subBar = new SubBar('.b-app-container > .b-sub-bar-container');
    UsersArea usersArea = new UsersArea();


    Connection connection = new Connection();
    Router router = new Router();
    StreamController viewStreamController = new StreamController<bool>.broadcast();

    Stream<bool> get onViewLoaded => viewStreamController.stream;

    init() {
        connection.init();

        bindEvents();
        initContainer();
        initComponents();
    }

    void initContainer() {
        mainArea = document.querySelector('body');

        mainArea
            .querySelector('.spinner')
            .classes
            .remove('loading');

        const TIMEOUT = const Duration(milliseconds: 300);

        new Timer(TIMEOUT, loadMainViewContainer);
    }


    void loadMainViewContainer() {
        mainArea.setInnerHtml(getTemplate());
        viewStreamController.add(true);
    }

    void bindEvents() {
//        onViewLoaded.listen((bool event) => print('!!! $event !!!'));
    }

    String getTemplate() {
        return """
                   <div class='b-app-container'>

                       <div class='b-top-bar-container'></div>
                       <div class='b-sub-bar-container'></div>

                       <div class='b-main-area-container'></div>

                   </div>
               """;
    }

    void initComponents() {
        topBar.init(router, connection, onViewLoaded);
        subBar.init(router, connection, onViewLoaded);
        usersArea.init(router, connection, onViewLoaded);
    }
}