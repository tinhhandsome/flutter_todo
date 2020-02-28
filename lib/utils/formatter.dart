import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as time_ago;

class Formatter {
  static String formatDateFrom(int dateTime) {
    if (dateTime == null) {
      return "";
    }

    var time = "";
    try {
      var date = DateTime.fromMillisecondsSinceEpoch(dateTime);
      if (date.millisecondsSinceEpoch < DateTime.now().millisecondsSinceEpoch) {
        time = time_ago.format(date);
      } else {
        final format = DateFormat('yyyy-MM-dd hh:mm');
        time = format.format(date);
      }
    } catch (_) {}
    return time;
  }

  static String formatDateNotAgoFrom(int dateTime) {
    if (dateTime == null) {
      return "";
    }
    var time = "";
    try {
      var date = DateTime.fromMillisecondsSinceEpoch(dateTime);
      final format = DateFormat('yyyy-MM-dd hh:mm');
      time = format.format(date);
    } catch (_) {}
    return time;
  }
}
