import 'dart:html';
import 'api_connector.dart';
import 'page.dart';
import 'dart:convert';

class ProfilePageModel {
    String name;
    num price_per_month;

    Map toJson() =>
        new Map()
            ..['name'] = name
            ..['price_per_month'] = price_per_month;
}

class DashboardPage implements Page {
    ButtonElement getUsersLink;
    DivElement mainArea;
    ProfilePageModel model;

    DashboardPage() {
        init();
        bindElements();
        bindEvents();
    }

    init() {
        model = new ProfilePageModel();
        print(runtimeType);
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
        var a = users.map((user) => '<div>${user['email']}</div>');
        return a.join('');
    }
}