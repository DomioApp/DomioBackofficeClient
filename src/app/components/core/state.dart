import 'actions.dart';
import 'user.dart';

class State {
    List<User> Users;

    State.initial() :
            Users = new List();

    State(State state, Action action) :
            Users = usersReducer(state.Users, action);
}


List<User> usersReducer(List<User> users, Action action) {
    switch (action.runtimeType) {
        case FetchUsers:
            users.add(new User());
            break;
    }

    return users;
}