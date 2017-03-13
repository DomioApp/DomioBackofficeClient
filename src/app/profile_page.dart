import 'dart:html';
import 'api_connector.dart';
import 'page.dart';
import 'config.dart';

class ProfilePageModel {
    String name;
    num price_per_month;

    Map toJson() =>
        new Map()
            ..['name'] = name
            ..['price_per_month'] = price_per_month;
}

class ProfilePage implements Page {
    ButtonElement deleteAccountButton;
    ProfilePageModel model;

    ProfilePage() {
        init();
        bindElements();
        bindEvents();
    }

    init() {
        model = new ProfilePageModel();
        print(runtimeType);
    }

    bindElements() {
        deleteAccountButton = querySelector('.b-delete-account-button');
    }

    bindEvents() {
        deleteAccountButton.onClick.listen(deleteAccount);
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

    deleteAccount(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        ButtonElement button = event.target;

        HttpRequest request = await deleteRequest('/user', null);

        window.console.log(request.response);

        if (request.readyState == HttpRequest.DONE &&
            (request.status == 200 || request.status == 0)) {
            window.location.assign('${siteUrl}/logout');
        }
    }
}