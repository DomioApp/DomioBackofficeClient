import 'dart:html';
import 'dart:async';

import '../ui/top_bar.dart';

class Backoffice {
    DivElement mainArea;

    TopBar topBar = new TopBar();

    init(String queryString) {
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

        const TIMEOUT = const Duration(milliseconds: 2400);

        new Timer(TIMEOUT, loadUi);
    }

    void loadUi() {
        print('loadUi');
        mainArea
            .querySelector('.spinner')
            .classes
            .remove('loading');

        const TIMEOUT = const Duration(milliseconds: 400);

        new Timer(TIMEOUT, loadElements);
    }

    void loadElements() {
        print('loadElements');
        mainArea.setInnerHtml(getTemplate());
        bindElements();
    }

    void bindElements() {
        topBar.init(mainArea.querySelector('.app-container > .top-bar-container'));
    }

    String getTemplate() {
        return """
                   <div class='app-container'>
                       <div class='top-bar-container'></div>
                       <div class='main-area-container'></div>
                   </div>
               """;
    }
}