import 'dart:html';
import 'dart:async';

import '../ui/top_bar.dart';
import '../ui/users_area.dart';
import 'connection.dart';

class Backoffice {
    DivElement mainArea;

    TopBar topBar = new TopBar();
    UsersArea usersArea = new UsersArea();
    Connection connection = new Connection();

    init(String queryString) {
        connection.init();

        initContainer(queryString);
    }


    bindEvents() {
//        getUsersLink.onClick.listen(getUsers);
    }

/*
    getUsers(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        HttpRequest request = await getRequest('/users', null);

        mainArea.setInnerHtml(loadUsersUi(JSON.decode(request.response)));
    }
*/

/*
    String loadUsersUi(List users) {
        var a = users.map((user) =>
        """
            <div>${user['email']}</div>
            <hr>
        """
        );
        return a.join('');
    }
*/
    void initContainer(String queryString) {
        mainArea = document.querySelector(queryString);

//        const TIMEOUT = const Duration(milliseconds: 2400);
        const TIMEOUT = const Duration(milliseconds: 240);

        new Timer(TIMEOUT, loadUi);
    }

    void loadUi() {
        print('loadUi');
        mainArea
            .querySelector('.spinner')
            .classes
            .remove('loading');

        const TIMEOUT = const Duration(milliseconds: 300);

        new Timer(TIMEOUT, loadElements);
    }

    void loadElements() {
        print('loadElements');
        mainArea.setInnerHtml(getTemplate());
        bindElements();
    }

    void bindElements() {
        topBar.init(mainArea.querySelector('.b-app-container > .b-top-bar-container'));
        usersArea.init(mainArea.querySelector('.b-app-container .b-users-area-container'), connection);
    }

    String getTemplate() {
        return """
                   <div class='b-app-container'>

                       <div class='b-top-bar-container'></div>

                       <div class='b-main-area-container'>
                           <div class='b-users-area-container'></div>
                       </div>

                   </div>
               """;
    }
}