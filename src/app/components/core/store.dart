import 'dart:async';

import 'state.dart';
import '../actions/action.dart';

class Store {
    final StreamController<Action> dispatch = new StreamController.broadcast();
    final StreamController<State> _stateController = new StreamController.broadcast();

    Stream<State> get subscribe => _stateController.stream;
    State _state = new State.initial();

    Store() {
        dispatch.stream.listen((action) {
            final state = new State(_state, action);
            _stateController.add(state);
            _state = state;
        });

//        dispatch.add(new InitAction());
    }

    State getState() {
        return _state;
    }
}