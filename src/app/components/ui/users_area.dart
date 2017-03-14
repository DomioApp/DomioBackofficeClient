import 'dart:html';
import 'dart:convert';

import '../core/connection.dart';

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


class UsersArea {
    Connection connection;
    DivElement container;

    init(DivElement containerInstance, Connection connectionInstance) {
        connection = connectionInstance;
        container = containerInstance;
        bindEvents();
    }

    bindEvents() {
        connection.onData.listen(updateView);
        connection.getRequest('/users', null);
    }

    void updateView(String data) {
        container.setInnerHtml(getTemplate(data));
    }

    String getTemplate(String data) {
        List<Map> decodedJson = JSON.decode(data);

        List<User> users = decodedJson.map((userMap) => new User(userMap));
        print(users);

        return """
                    <div class="b-users-area">
                        <p>$data</p>
                    </div>
                """;
    }
}