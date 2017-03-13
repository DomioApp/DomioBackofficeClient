import 'dart:html';
import 'page.dart';
import './config.dart';
import 'api_connector.dart';

class CreateSubscriptionPageModel {
    String name;
    num price_per_month;

    Map toJson() =>
        new Map()
            ..['name'] = name
            ..['price_per_month'] = price_per_month;
}

class CreateSubscriptionPage implements Page {
    FormElement form;
    ButtonElement button;
    CreateSubscriptionPageModel model;

    CreateSubscriptionPage() {
        init();
        bindElements();
        bindEvents();
    }

    init() {
        model = new CreateSubscriptionPageModel();
        print(runtimeType);
    }

    bindElements() {
        form = querySelector('form');
        button = form.querySelector('button');
    }

    bindEvents() {
        form.onSubmit.listen(handleSubmit);
    }

    handleSubmit(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        HttpRequest request = await postRequest('/subscriptions', getState());

        if (request.readyState == HttpRequest.DONE &&
            (request.status == 200 || request.status == 0)) {
            window.location.assign('${siteUrl}/profile/subscriptions');
        }
    }

    getState() {
        return {
            'domain': button.value
        };
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
}