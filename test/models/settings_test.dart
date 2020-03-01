import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/models/settings.dart';

void main() {
  group("Settings", () {
    test("toJson", () {
      Settings settings = Settings(themeMode: 1, languageCode: "vi");
      expect(settings.toJson(), {"theme_mode": 1, "language_code": "vi"});
    });
    test("fromJson", () {
      Settings settings = Settings(themeMode: 1);
      var json = {"theme_mode": 1};
      expect(Settings.fromJson(json).toJson(), settings.toJson());
    });
    // If add entry, not test => failed
    test("size of key = 2", () {
      Settings settings = Settings();
      expect(settings.toJson().keys.length, 2);
    });
  });
}
