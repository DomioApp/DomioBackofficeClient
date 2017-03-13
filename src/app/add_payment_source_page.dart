import 'dart:html';
import 'page.dart';
import 'config.dart';
import 'api_connector.dart';

class AddPaymentSourcePageModel {
    String name_on_the_card;
    num expiry_month;
    num expiry_year;
    num cvc;
    num card_number;

    Map toJson() =>
        new Map()
            ..['name_on_the_card'] = name_on_the_card
            ..['expiry_month'] = expiry_month
            ..['expiry_year'] = expiry_year
            ..['cvc'] = cvc
            ..['card_number'] = card_number;
}

class AddPaymentSourcePage implements Page {
    FormElement form;

    TextInputElement nameOnTheCardInput;
    NumberInputElement expiryMonthInput;
    NumberInputElement expiryYearInput;
    NumberInputElement cvcInput;
    NumberInputElement cardNumberInput;

    ButtonElement addButton;

    AddPaymentSourcePageModel model;

    AddPaymentSourcePage() {
        init();
        bindElements();
        bindEvents();
    }

    init() {
        model = new AddPaymentSourcePageModel();
        print(runtimeType);
    }

    bindElements() {
        form = querySelector('form');
        HiddenInputElement domainNameInput = form.querySelector('input[name="domain_name"]');
        addButton = querySelector('.b-add-payment-source-button');

        nameOnTheCardInput = form.querySelector('input[name="name_on_the_card"]');
        expiryMonthInput = form.querySelector('input[name="expiry_month"]');
        expiryYearInput = form.querySelector('input[name="expiry_year"]');
        cvcInput = form.querySelector('input[name="cvc"]');
        cardNumberInput = form.querySelector('input[name="card_number"]');
    }

    bindEvents() {
        form.onSubmit.listen(handleSubmit);
//        expiryMonthInput.onChange.listen(updateModel);
    }

    handleSubmit(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        window.console.log(getState());

        HttpRequest request = await postRequest('/cards', getState());
        window.console.log(request.response);

        if (request.readyState == HttpRequest.DONE &&
            (request.status == 200 || request.status == 0)) {
            print("card saved");
            window.location.assign('/profile/payments');
        }
    }

    updateModel(Event event) {
        InputElement input = event.target;

        switch (input.name) {
            case 'price_per_month':
                model.expiry_month = num.parse(input.value);
                break;
        }
    }

    getState() {
        return {
            'name_on_the_card': nameOnTheCardInput.value,
            'expiry_month': int.parse(expiryMonthInput.value),
            'expiry_year': int.parse(expiryYearInput.value),
            'cvc': int.parse(cvcInput.value),
            'card_number': int.parse(cardNumberInput.value),
        };
    }
}