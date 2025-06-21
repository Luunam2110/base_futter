import 'dart:io';

import 'package:flutter/foundation.dart' as foundation show debugPrint, kDebugMode;
import 'package:logger/logger.dart' show Logger, PrettyPrinter;

class AppLogger {
  AppLogger._();

  static const _gray = '\x1B[90m'; // ANSI Gray
  static const _reset = '\x1B[0m'; // Reset color

  static final prettyLogger = Logger(
    printer: foundation.kDebugMode
        ? PrettyPrinter(
            colors: Platform.isAndroid,
            printEmojis: Platform.isAndroid,
          )
        : null,
    output: null,
  );

  static void logger(String message, [List<String> tags = const ['default']]) {
    final prefix = tags.map((e) => '[${e.toUpperCase()}]').join();
    foundation.debugPrint('${Platform.isAndroid ? _gray : ''}$prefix${Platform.isAndroid ? _reset : ''} $message');
  }
}
