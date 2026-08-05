import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<State,Action,Navigation> extends Cubit<State> {
  BaseCubit(super.initialState);

  Future<void> doAction(Action action);
  final StreamController<Navigation> _streamController = StreamController.broadcast();

  void emitNavigation(Navigation navigationAction){
    _streamController.add(navigationAction);
  }

  Stream<Navigation> get navigation => _streamController.stream;

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }

}