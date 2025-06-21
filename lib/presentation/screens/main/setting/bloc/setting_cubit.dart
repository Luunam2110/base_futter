import 'package:dafactory/core/base_bloc/base_cubit.dart';
import 'package:dafactory/presentation/screens/main/setting/bloc/setting_state.dart';

class SettingCubit extends BaseCubit<SettingState, dynamic> {
  SettingCubit() : super(const SettingInitialState());
}
