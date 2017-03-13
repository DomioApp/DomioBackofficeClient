import 'dart:html';
import 'api_connector.dart';
import 'page.dart';
import 'config.dart';

class LoginPageModel {
    String email;
    String password;

    Map toJson() =>
        new Map()
            ..['email'] = email
            ..['password'] = password;

}

class LoginPage implements Page {
    FormElement form;
    DivElement errorMessageContainer;
    EmailInputElement emailInput;
    PasswordInputElement passwordInput;
    LoginPageModel model;

    LoginPage() {
        init();
        bindElements();
        bindEvents();
    }

    init() {
        print(runtimeType);
        model = new LoginPageModel();
    }

    bindElements() {
        form = querySelector('form') as FormElement;
        emailInput = form.querySelector('input[name="email"]');
        passwordInput = form.querySelector('input[name="password"]');
        errorMessageContainer =
            form.querySelector('.b-error-message-container');
    }

    bindEvents() {
        emailInput.onChange.listen(updateModel);
        passwordInput.onChange.listen(updateModel);

        form.onSubmit.listen(handleSubmit);
    }

    handleSubmit(Event event) async {
        event.preventDefault();
        event.stopPropagation();

        window.console.log(getState());

        HttpRequest request = await postRequest('/user/login', getState());

        window.console.log(model);

        window.console.log(request.response);

        if (request.readyState == HttpRequest.DONE)
            if (request.status == 200 || request.status == 0) {
                var token = new Token.fromJsonString(request.responseText);

                window.localStorage['token'] = token.token;
                window.localStorage['email'] = token.email;

                document.cookie = 'token=${token.token}';
                document.cookie = 'email=${token.email}';

                window.location.assign('${siteUrl}/profile/domains');
            }
        if (request.status == 401 || request.status == 0) {
            showError();
        }
    }

    showError() {
        errorMessageContainer.style.display = 'block';
        errorMessageContainer.text =
        "Couldn't login. Please check your email and password";
    }

    getState() {
        return {
            'email': '${emailInput.value}',
            'password': '${passwordInput.value}'
        };
    }

    updateModel(Event event) {
        InputElement input = event.target;

        switch (input.name) {
            case 'email':
                model.email = input.value;
                break;
            case 'password':
                model.password = input.value;
                break;
        }
    }
}