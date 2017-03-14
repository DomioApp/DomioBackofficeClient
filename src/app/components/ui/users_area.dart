import 'dart:html';
import 'dart:convert';
import 'dart:async';

import '../core/connection.dart';
import '../core/router.dart';
import '../core/user.dart';

import 'spinner.dart';
import 'user_item.dart';


class UsersArea {
    Connection connection;
    DivElement container;
    String containerQuerySelector;
    Stream onViewLoaded;

    void init(Router router, Connection connectionInstance, Stream onViewLoadedInstance) {
        connection = connectionInstance;
        onViewLoaded = onViewLoadedInstance;
        bindEvents();
    }

    void bindEvents() {
        connection.onUsersData.listen(updateView);
    }

    void render() {
        if (container == null) {
            container = document.querySelector('.b-main-area-container');
        }

        showSpinner();

        connection.getRequest('/users', null, connection.usersDataStreamController);
    }

    void showSpinner() {
        Spinner spinner = new Spinner();
        spinner.show(container);
    }


    void updateView(String data) {
        container.children.clear();
        container.append(getTemplate(data));
    }


    void showUserDetails(MouseEvent event) {
        event.preventDefault();
        event.stopPropagation();

        print(event.target);
    }

    DivElement getTemplate(String data) {
        NodeList usersList = loadUsersList(data);

        DivElement container = new Element.tag('div');
        container.classes.add('b-users-area');
        usersList.forEach((userItem) => container.append(userItem));

        return container;
    }

    NodeList loadUsersList(String data) {
        List<Map> decodedJson = JSON.decode(data);
        List<User> users = decodedJson.map((userMap) => new User(userMap));
        List<UserItem> userItems = users.map((user) => new UserItem(user));

        return userItems.map((UserItem user) => user.getTemplate());
    }
}