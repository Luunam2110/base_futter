import 'package:dafactory/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    AppLogger.logger('onCreate', ['BLOC', '${bloc.runtimeType}']);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    AppLogger.logger('onChange\n $change', ['BLOC', '${bloc.runtimeType}']);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLogger.logger('onError -- $error', ['BLOC', '${bloc.runtimeType}']);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    AppLogger.logger('onClose', ['BLOC', '${bloc.runtimeType}']);
  }
}
