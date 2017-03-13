import 'dart:html';
import 'page.dart';
import 'config.dart';
import 'api_connector.dart';

class DomainEditPageModel {
    String name;
    num price_per_month;

    Map toJson() =>
        new Map()
            ..['name'] = name
            ..['price_per_month'] = price_per_month;
}

class DomainEditPage implements Page {
    FormElement form;
    TextInputElement nameInput;
    TextInputElement priceInput;
    RadioButtonInputElement visibilityInput;
    ButtonElement deleteButton;

    DomainEditPageModel model;
    String domainName;

    DomainEditPage() {
        init();
        bindElements();
        bindEvents();
    }

    init() {
        model = new DomainEditPageModel();
        print(runtimeType);
    }

    bindElements() {
        form = querySelector('form');
        HiddenInputElement domainNameInput = form.querySelector('input[name="domain_name"]');
        deleteButton = querySelector('.b-delete-domain-button');
        priceInput = form.querySelector('input[name="price_per_month"]');

        domainName = domainNameInput.value;
    }

    bindEvents() {
        form.onSubmit.listen(handleSubmit);
        priceInput.onChange.listen(updateModel);
        deleteButton.onClick.listen(deleteDomain);
    }

    handleSubmit(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        HttpRequest request = await putRequest('/domain/${domainName}', getState());
        window.console.log(request.response);

        if (request.readyState == HttpRequest.DONE &&
            (request.status == 200 || request.status == 0)) {
            window.location.assign('${siteUrl}/profile/domains');
        }
    }

    updateModel(Event event) {
        InputElement input = event.target;

        switch (input.name) {
            case 'price_per_month':
                model.price_per_month = num.parse(input.value);
                break;
        }
    }

    getState() {
        visibilityInput = form.querySelector('input[name="visible"]:checked');

        return {
            'price_per_month': int.parse(priceInput.value),
            'is_visible': visibilityInput.value == 'visible',
        };
    }

    deleteDomain(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        ButtonElement button = event.target;

        HttpRequest request = await deleteRequest('/domain/${button.value}', null);

        window.console.log(request.response);

        if (request.readyState == HttpRequest.DONE &&
            (request.status == 200 || request.status == 0)) {
            window.location.assign('${siteUrl}/profile/domains');
        }
    }


}