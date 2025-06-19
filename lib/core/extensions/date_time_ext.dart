import 'package:dafactory/core/constants/date_format_constants.dart' show DateTimeFormatConstants;
import 'package:intl/intl.dart' show DateFormat;

extension DateTimeExt on DateTime {
  String toPattern({String pattern = DateTimeFormatConstants.dateTimeFormat}) {
    try {
      return DateFormat(pattern).format(this);
    } catch (_) {
      return '';
    }
  }
}
