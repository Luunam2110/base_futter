import 'package:dafactory/core/base_bloc/base_cubit.dart';
import 'package:dafactory/presentation/screens/main/home/cubit/home_state.dart';

class HomeCubit extends BaseCubit<HomeState, dynamic> {
  HomeCubit() : super(const HomeLoadingState()){
    fetch();
  }

  Future<void> fetch() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(const HomeLoadedState());
  }
}
