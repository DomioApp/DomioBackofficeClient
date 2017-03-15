import '../actions/action.dart';
import '../model/user.dart';
import '../model/domain.dart';
import '../reducers/users_reducer.dart';
import '../reducers/pending_domains_reducer.dart';

class State {
    List<User> Users;
    List<Domain> PendingDomains;

    State.initial() {
        Users = new List<User>();
        PendingDomains = new List<Domain>();
    }

    State(State state, Action action) {
        Users = usersReducer(state, action).Users;
        PendingDomains = pendingDomainsReducer(state, action).PendingDomains;
    }
}
