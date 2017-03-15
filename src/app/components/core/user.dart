class User {
    String Email;
    String Id;
    String Role;

    User() {}

    User.fromMap(Map userMap) {
        Email = userMap['email'];
        Id = userMap['id'];
        Role = userMap['role'];
    }
}
