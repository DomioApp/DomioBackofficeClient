import 'dart:html';
import 'dart:async';

import '../core/connection.dart';
import '../core/router.dart';
import '../model/payload.dart';
import '../core/requests.dart';

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
        connection.onData.listen(updateView);
    }

    void render() {
        if (container == null) {
            container = document.querySelector('.b-main-area-container');
        }

        showSpinner();

        connection.sendRequest(Requests.FetchUsers);
    }

    void showSpinner() {
        Spinner spinner = new Spinner();
        spinner.show(container);
    }


    void updateView(Payload payload) {
        container.children.clear();
        container.append(getTemplate(payload.data));
    }


    void showUserDetails(MouseEvent event) {
        event.preventDefault();
        event.stopPropagation();
    }

    DivElement getTemplate(List data) {
        NodeList usersList = loadUsersList(data);

        DivElement container = new Element.tag('div');
        container.classes.add('b-users-area');
        usersList.forEach((userItem) => container.append(userItem));

        return container;
    }

    NodeList loadUsersList(List data) {
        List<UserItem> userItems = data.map((user) => new UserItem(user));

        return userItems.map((UserItem user) => user.getTemplate());
    }
}