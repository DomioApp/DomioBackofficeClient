import '../core/state.dart';
import '../actions/action.dart';
import '../actions/fetch_pending_domains_action.dart';

State pendingDomainsReducer(State state, Action action) {
    if (action is FetchPendingDomainsAction) {
        state.PendingDomains = action.payload;
    }

    return state;
}