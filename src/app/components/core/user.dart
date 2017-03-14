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
