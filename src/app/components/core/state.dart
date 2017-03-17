import '../actions/action.dart';
import '../model/user.dart';
import '../model/domain.dart';
import '../model/api_status.dart';

import '../reducers/users_reducer.dart';
import '../reducers/pending_domains_reducer.dart';
import '../reducers/api_status_reducer.dart';

class State {
    List<User> users;
    List<Domain> pendingDomains;
    ApiStatus apiStatus;

    State.initial() {
        users = new List<User>();
        pendingDomains = new List<Domain>();
    }

    State(State state, Action action) {
        users = usersReducer(state, action).users;
        pendingDomains = pendingDomainsReducer(state, action).pendingDomains;
        apiStatus = apiStatusReducer(state, action).apiStatus;
    }
}
