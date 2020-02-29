import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/utils/formatter.dart';

void main() {
  group("Formatter", () {
    test("formatDateFrom - a moment ago", () {
      var actual =
          Formatter.formatDateFrom(DateTime.now().millisecondsSinceEpoch);
      expect(actual, 'a moment ago');
    });

    test("formatDateNotAgoFrom", () {
      // FIXME
      var value =DateTime.now().millisecondsSinceEpoch;
      var actual = Formatter.formatDateNotAgoFrom(value);
      expect(actual.isNotEmpty, true);
    });
  });
}
