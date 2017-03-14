import 'dart:html';
import 'dart:convert';
import 'dart:async';

import '../core/connection.dart';
import '../core/router.dart';
import 'spinner.dart';

class User {
    String Email;
    String Id;
    String Role;

    User(Map userMap) {
        Email = userMap['email'];
        Id = userMap['id'];
        Role = userMap['role'];
    }
}


class PendingDomainsArea {
    Connection connection;
    DivElement container;
    String containerQuerySelector;
    Stream onViewLoaded;

    void init(Router router, Connection connectionInstance, Stream onViewLoadedInstance) {
        connection = connectionInstance;
        onViewLoaded = onViewLoadedInstance;
        bindEvents();
    }

    void bindEvents() {
        connection.onPendingDomainsData.listen(updateView);
    }

    void render() {
        if (container == null) {
            container = document.querySelector('.b-main-area-container');
        }

        showSpinner();

        connection.getRequest('/domains/pending', null, connection.pendingDomainsDataStreamController);
    }

    void showSpinner() {
        Spinner spinner = new Spinner();
        spinner.show(container);
    }

    void updateView(String data) {
        document.body
            .querySelector('.spinner')
            .classes
            .remove('loading');

        const TIMEOUT = const Duration(milliseconds: 300);

        new Timer(TIMEOUT, () => container.setInnerHtml(getTemplate(data)));
    }

    String getTemplate(String data) {
        String usersList = loadUsersList(data);

        return """
                   <div class="b-pending-domains-area">
                       <p>$usersList</p>
                   </div>
               """;
    }

    String loadUsersList(String data) {
        List<Map> decodedJson = JSON.decode(data);
        List<User> users = decodedJson.map((userMap) => new User(userMap));
        return users.map(
                (User user) => """
                                <div class='b-user-item-container'>
                                    ${user.Email}
                                    ${user.Id}
                                </div>
                               """
        ).join('');
    }
}