import 'dart:html';
import 'dart:async';

import 'connection.dart';
import 'router.dart';
import 'store.dart';
import '../model/payload.dart';
import 'requests.dart';

import '../ui/top_bar.dart';
import '../ui/sub_bar.dart';
import '../ui/users_area.dart';
import '../ui/pending_domains_area.dart';
import '../actions/fetch_users_action.dart';
import '../actions/fetch_pending_domains_action.dart';
import '../actions/fetch_api_status_action.dart';

class Backoffice {
    DivElement mainArea;
    TopBar topBar = new TopBar('.b-app-container > .b-top-bar-container');
    SubBar subBar = new SubBar('.b-app-container > .b-sub-bar-container');
    UsersArea usersArea = new UsersArea();
    PendingDomainsArea pendingDomainsArea = new PendingDomainsArea();

    Store store = new Store();
    Connection connection = new Connection();

    Router router = new Router();
    StreamController viewStreamController = new StreamController<bool>.broadcast();

    Stream<bool> get onMainViewLoaded => viewStreamController.stream;

    void init() {
        bindEvents();
//        initContainer();
//        initComponents();
    }

/*
    void initContainer() {
        mainArea = document.querySelector('body');

        mainArea
            .querySelector('.spinner')
            .classes
            .remove('loading');

        const TIMEOUT = const Duration(milliseconds: 300);

        new Timer(TIMEOUT, loadMainViewContainer);
    }
*/


/*
    void loadMainViewContainer() {
        mainArea.setInnerHtml(getTemplate());
        viewStreamController.add(true);
    }
*/

    void bindEvents() {
        connection.onData.listen(loadData);

//        store.subscribe.listen((state) => print('${state}'));

//        onMainViewLoaded.listen((bool event) => print('Main view loaded'));
//        router.onRouteChange.listen(loadView);
//            connection.sendRequest(Requests.FetchUsers);
    }

    void loadData(Payload payload) {
        if (payload.endpoint == Requests.FetchPendingDomains) {
            store.dispatch.add(new FetchPendingDomainsAction());
        } else if (payload.endpoint == Requests.FetchUsers) {
            store.dispatch.add(new FetchUsersAction.fromObject(payload.data));
        } else if (payload.endpoint == Requests.FetchApiStatus) {
            store.dispatch.add(new FetchApiStatusAction.fromObject(payload.data));
        }
    }

/*
    void loadView(String route) {
        if (route == 'users') {
            usersArea.render();
        } else if (route == 'pending-domains') {
            pendingDomainsArea.render();
        }
    }
*/

/*
    String getTemplate() {
        return """
                   <div class='b-app-container'>

                       <div class='b-top-bar-container'></div>
                       <div class='b-sub-bar-container'></div>

                       <div class='b-main-area-container'></div>

                   </div>
               """;
    }
*/

/*
    void initComponents() {
        topBar.init(router, connection, onMainViewLoaded);
        subBar.init(router, connection, onMainViewLoaded);
        usersArea.init(router, connection, onMainViewLoaded);
        pendingDomainsArea.init(router, connection, onMainViewLoaded);
    }
*/
}