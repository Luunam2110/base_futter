import 'package:dafactory/core/constants/date_format_constants.dart' show DateTimeFormatConstants;
import 'package:intl/intl.dart';

extension StringExt on String? {
  bool get isStrEmpty {
    return this == null || this!.trim().isEmpty;
  }

  bool get isStrNotEmpty {
    return this != null && this!.isNotEmpty;
  }

  DateTime? getDateTime({
    String pattern = DateTimeFormatConstants.serverFormat,
  }) {
    return DateFormat(pattern).tryParse(this ?? '', true)?.toLocal();
  }
}
