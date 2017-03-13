import 'dart:html';
import 'api_connector.dart';
import 'dart:convert';

class BackofficeModel {
    String name;
    num price_per_month;

    Map toJson() =>
        new Map()
            ..['name'] = name
            ..['price_per_month'] = price_per_month;
}

class Backoffice {
    ButtonElement getUsersLink;
    DivElement mainArea;
    BackofficeModel model;

    Backoffice() {
        init();
        bindElements();
        bindEvents();
    }

    init() {
        model = new BackofficeModel();
    }

    bindElements() {
        getUsersLink = querySelector('.b-top-bar-container a[href="/users"]');
        mainArea = querySelector('.b-profile-main-area-container');
    }

    bindEvents() {
        getUsersLink.onClick.listen(getUsers);
    }

    updateModel(Event event) {
        InputElement input = event.target;
        window.console.log(model);

        switch (input.name) {
            case 'name':
                model.name = input.value;
                break;
            case 'price_per_month':
                model.price_per_month = num.parse(input.value);
                break;
        }
    }

    getUsers(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        HttpRequest request = await getRequest('/users', null);

        mainArea.setInnerHtml(loadUsersUi(JSON.decode(request.response)));
    }

    String loadUsersUi(List users) {
        var a = users.map((user) =>
        """
            <div>${user['email']}</div>
            <hr>
        """
        );
        return a.join('');
    }
}