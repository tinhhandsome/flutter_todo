import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/utils/formatter.dart';

void main() {
  group("Formatter", () {
    test("formatDateFrom - a moment ago", () {
      var actual =
          Formatter.formatDateFrom(DateTime.now().millisecondsSinceEpoch);
      expect(actual, 'a moment ago');
    });

    test("formatDateNotAgoFrom - 2020-02-29 12:10", () {
      var actual = Formatter.formatDateNotAgoFrom(1582953009186);
      expect(actual, "2020-02-29 12:10");
    });
  });
}
