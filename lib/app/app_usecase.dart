import 'package:dafactory/domain/usecase/auth/get_auth_status_usecase.dart' show GetAuthStatusUseCase;
import 'package:dafactory/domain/usecase/locate/load_locale_usecase.dart' show LoadLocaleUseCase;
import 'package:dafactory/domain/usecase/locate/save_locale_usecase.dart' show SaveLocaleUseCase;
import 'package:dafactory/domain/usecase/theme/load_theme_mode_usecase.dart' show LoadThemeModeUseCase;
import 'package:dafactory/domain/usecase/theme/save_theme_mode_usecase.dart' show SaveThemeModeUseCase;

class AppUseCase with LoadLocaleUseCase, SaveLocaleUseCase, SaveThemeModeUseCase, LoadThemeModeUseCase, GetAuthStatusUseCase {}
