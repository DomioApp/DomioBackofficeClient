import '../core/state.dart';
import '../actions/action.dart';
import '../actions/fetch_users_action.dart';

State usersReducer(State state, Action action) {
    if (action is FetchUsersAction) {
        state.users = action.payload;
    }

    return state;
}
