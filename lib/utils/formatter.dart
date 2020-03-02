import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as time_ago;

class Formatter {
  static String formatDateFrom(int millisecondsSinceEpoch,
      {String locale = "en"}) {
    if (millisecondsSinceEpoch == null) {
      return "";
    }

    var time = "";
    try {
      var date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
      if (millisecondsSinceEpoch < DateTime.now().millisecondsSinceEpoch) {
        time = time_ago.format(date, locale: locale);
      } else {
        time = formatDateNotAgoFrom(millisecondsSinceEpoch);
      }
    } catch (_) {}
    return time;
  }

  static String formatDateNotAgoFrom(int millisecondsSinceEpoch) {
    if (millisecondsSinceEpoch == null) {
      return "";
    }
    var time = "";
    try {
      var date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
      final format = DateFormat('yyyy-MM-dd hh:mm');
      time = format.format(date);
    } catch (_) {}
    return time;
  }
}
