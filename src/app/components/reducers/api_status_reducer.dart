import '../core/state.dart';
import '../actions/action.dart';
import '../actions/fetch_api_status_action.dart';

State apiStatusReducer(State state, Action action) {

    if (action is FetchApiStatusAction) {
        state.apiStatus = action.payload;
    }

    return state;
}