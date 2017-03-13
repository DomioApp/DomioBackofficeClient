import 'dart:html';
import 'api_connector.dart';
import 'page.dart';

class SubscriptionPageModel {
    String name;
    num price_per_month;

    Map toJson() =>
        new Map()
            ..['name'] = name
            ..['price_per_month'] = price_per_month;
}

class SubscriptionPage implements Page {
    ButtonElement deleteSubscriptionButton;
    ElementList<ButtonElement> deleteRecordButtons;
    FormElement subscriptionRecordForm;
    InputElement subscriptionRecordInput;
    InputElement subIdInput;
    SelectElement recordTypeSelect;

    SubscriptionPageModel model;

    SubscriptionPage() {
        init();
        bindElements();
        bindEvents();
    }

    init() {
        model = new SubscriptionPageModel();
        print(runtimeType);
    }

    bindElements() {
        deleteSubscriptionButton = querySelector('.delete-subscription-button');
        deleteRecordButtons = querySelectorAll('.delete-record-button');
        subscriptionRecordForm = querySelector('.b-subscription-record-form');
        subscriptionRecordInput = querySelector('.b-subscription-record-form input.value-input');
        recordTypeSelect = querySelector('.b-subscription-record-form select.value-type-select');
        subIdInput = querySelector('input.subscription-id-input');
    }

    bindEvents() {
        deleteSubscriptionButton.onClick.listen(deleteSubscription);
        deleteRecordButtons.onClick.listen(deleteRecord);
        subscriptionRecordForm.onSubmit.listen(updateSubscription);
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

    updateSubscription(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        SubmitButtonInputElement button = event.target;

        String subId = subIdInput.getAttribute('value');

        window.console.log(getState());

        HttpRequest request = await putRequest('/subscription/${subId}/records', getState());

        window.console.log(request.response);

//        if (request.readyState == HttpRequest.DONE &&
//            (request.status == 200 || request.status == 0)) {
//            window.location.assign('/profile/subscriptions');
//        }
    }

    deleteSubscription(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        ButtonElement button = event.target;

        print(button.value);

        HttpRequest request = await deleteRequest('/subscription/${button.value}', null);

        window.console.log(request.response);

        if (request.readyState == HttpRequest.DONE &&
            (request.status == 200 || request.status == 0)) {
            window.location.assign('/profile/subscriptions');
        }
    }

    deleteRecord(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        ButtonElement button = event.target;

        String subId = subIdInput.getAttribute('value');

        print(button.value);
        print(subId);

        HttpRequest request = await deleteRequest('/subscription/${subId}/records', getRecordState(event));

        window.console.log(request.response);
    }


    getState() {
        return {
            'key': recordTypeSelect.options[recordTypeSelect.selectedIndex].value,
            'value': subscriptionRecordInput.value
        };
    }

    getRecordState(Event event) {
        ButtonElement deleteButton = event.target;
        var recordType = deleteButton.parent.parent.getAttribute('data-type');
        return {
            'key': recordType,
            'value': deleteButton.value
        };
    }
}