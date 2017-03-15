import 'dart:convert';

class Token {
    String email;
    String token;
    String id;

    Token.fromJsonString(String jsonString) {
        Map resp = JSON.decode(jsonString);

        email = resp['email'];
        token = resp['token'];
        id = resp['id'];

        if (email == null || token == null || id == null) {
            throw new StateError('one of fields is empty');
        }
    }
}
