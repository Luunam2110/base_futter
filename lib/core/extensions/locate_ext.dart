import 'dart:ui' show Locale;

extension LocaleExt on String {
  /// Convert a string to a [Locate] enum value.
  Locale toLocate() {
    switch (this) {
      case 'en':
        return const Locale('en', 'US');
      case 'vi':
        return const Locale('vi', 'VN');
      default:
        return const Locale('vi', 'VN');
    }
  }
}