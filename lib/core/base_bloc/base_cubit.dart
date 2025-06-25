import 'dart:async';

import 'package:dafactory/core/base_bloc/base_state.dart' show BaseState;
import 'package:dafactory/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<S extends BaseState, E> extends BlocBase<S> {
  BaseCubit(super.initialState);

  final _effectController = StreamController<E>.broadcast();

  Stream<E> get effects => _effectController.stream;


  void emitEffect(E effect) {
    AppLogger.logger('emitEffect\n ${E.runtimeType}', ['BLOC', '$runtimeType']);
    _effectController.add(effect);
  }

  @override
  Future<void> close() {
    if(isClosed) return Future.value();
    _effectController.close();
    return super.close();
  }
}
