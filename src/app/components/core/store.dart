import 'dart:async';

import 'state.dart';
import 'actions.dart';
import 'connection.dart';

class Store {
    final StreamController<Action> dispatch = new StreamController.broadcast();
    final StreamController<State> _stateController = new StreamController.broadcast();

    Stream<State> get subscribe => _stateController.stream;
    State _state = new State.initial();

    Connection connection;

    Store() {
        dispatch.stream.listen((action) {
            final state = new State(_state, action);
            _stateController.add(state);
            _state = state;
        });

        dispatch.add(new InitAction());
    }
}