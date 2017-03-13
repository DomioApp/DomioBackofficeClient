import 'dart:html';
import 'page.dart';
import './config.dart';
import 'api_connector.dart';

class AddDomainPageModel {
    String Name;
    num PricePerMonth;

    AddDomainPageModel() {
        Name = "";
        PricePerMonth = 0;
    }

    Map toJson() =>
        new Map()
            ..['name'] = Name
            ..['price_per_month'] = PricePerMonth;
}

class AddDomainPage implements Page {
    FormElement form;
    TextInputElement nameInput;
    TextInputElement priceInput;
    AddDomainPageModel model;

    AddDomainPage() {
        init();
        bindElements();
        loadData();
        bindEvents();
    }

    void init() {
        model = new AddDomainPageModel();
    }

    void bindElements() {
        form = querySelector('form');
        nameInput = form.querySelector('input[name="name"]');
        priceInput = form.querySelector('input[name="price_per_month"]');
    }

    void loadData() {
        nameInput.value = model.Name;
        priceInput.value = model.PricePerMonth.toString();
    }

    void bindEvents() {
        form.onSubmit.listen(handleSubmit);

        nameInput.onInput.listen(updateModel);
        priceInput.onInput.listen(updateModel);
    }

    handleSubmit(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        if (!isValid(model)) {
            window.console.log("wrong data");
            return;
        }

        HttpRequest request = await postRequest('/domains', model);
        window.console.log(request.response);

        if (request.readyState == HttpRequest.DONE &&
            (request.status == 200 || request.status == 0)) {
            window.location.assign('${siteUrl}/profile/domain/${model.Name}');
        }
    }

    bool isValid(AddDomainPageModel model) {
        return model.Name.length > 0 && model.PricePerMonth > 0;
    }

    void updateModel(Event event) {
        InputElement input = event.target;

        switch (input.name) {
            case 'name':
                model.Name = input.value;
                break;
            case 'price_per_month':
                model.PricePerMonth = num.parse(input.value);
                break;
        }
        window.console.log(model);
    }
}