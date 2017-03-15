import 'action.dart';
import '../model/user.dart';
import '../model/payload.dart';

class FetchUsersAction extends Action {
    List<User> data;

    FetchUsersAction(Payload payload) {
        data = payload.data.map((item) => new User());
    }
}
