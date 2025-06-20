import 'dart:async';

import 'package:dafactory/core/base_bloc/base_state.dart' show BaseState;
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<S extends BaseState, E> extends BlocBase<S> {
  BaseCubit(super.initialState);

  final _effectController = StreamController<E>();

  Stream<E> get effects => _effectController.stream;


  void emitEffect(E effect) {
    _effectController.add(effect);
  }

  @override
  Future<void> close() {
    if(isClosed) return Future.value();
    _effectController.close();
    return super.close();
  }
}
