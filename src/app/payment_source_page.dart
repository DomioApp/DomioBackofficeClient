import 'dart:html';
import 'api_connector.dart';
import 'page.dart';
import 'config.dart';

class PaymentSourcePageModel {
    String name;
    num price_per_month;

    Map toJson() =>
        new Map()
            ..['name'] = name
            ..['price_per_month'] = price_per_month;
}

class PaymentSourcePage implements Page {
    ButtonElement deletePaymentSourceButton;
    PaymentSourcePageModel model;

    PaymentSourcePage() {
        init();
        bindElements();
        bindEvents();
    }

    init() {
        model = new PaymentSourcePageModel();
        print(runtimeType);
    }

    bindElements() {
        deletePaymentSourceButton = querySelector('.delete-payment-source-button');
    }

    bindEvents() {
        deletePaymentSourceButton.onClick.listen(deletePaymentSource);
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

    deletePaymentSource(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        ButtonElement button = event.target;

        print(button.value);

        HttpRequest request = await deleteRequest('/cards/${button.value}', null);

        window.console.log(request.response);

        if (request.readyState == HttpRequest.DONE &&
            (request.status == 200 || request.status == 0)) {
            print(request.response);
            window.location.assign('/profile/payments');
        }
    }
}