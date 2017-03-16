import 'action.dart';
import '../model/user.dart';

class FetchUsersAction implements Action<List<User>> {
    String type = 'FETCH_USERS_ACTION';
    List<User> payload;

    FetchUsersAction.fromObject(List data) {
        payload = data.map((Map userMap) => new User.fromMap(userMap));
    }

}
