import 'dart:html';
import 'dart:convert';
import 'dart:async';

import '../core/connection.dart';
import '../core/router.dart';

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
    String containerQuerySelector;
    Stream onViewLoaded;

    void init(Router router, Connection connectionInstance, Stream onViewLoadedInstance) {
        connection = connectionInstance;
        onViewLoaded = onViewLoadedInstance;
        bindEvents();
    }

    void bindEvents() {
        connection.onData.listen(render);
//        connection.getRequest('/users', null);
        onViewLoaded.listen((bool event) => print(event));
    }

    void render(String data) {
        if (container == null) {
            container = document.querySelector('.b-main-area-container');
        }

        container.setInnerHtml(getTemplate(data));
    }

    String getTemplate(String data) {
        String usersList = loadUsersList(data);

        return """
                   <div class="b-users-area">
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