import 'package:flutter/foundation.dart' as foundation show kDebugMode;
import 'package:logger/logger.dart' show Logger, PrettyPrinter;

final logger = Logger(
  filter: null,
  printer: foundation.kDebugMode ? PrettyPrinter() : null,
  output: null,
);
