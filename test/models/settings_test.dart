import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/models/settings.dart';

void main() {
  group("Settings", () {
    test("toJson", () {
      Settings settings = Settings(themeMode: 1);
      expect(settings.toJson(), {"theme_mode": 1});
    });
    test("fromJson", () {
      Settings settings = Settings(themeMode: 1);
      var json = {"theme_mode": 1};
      expect(Settings.fromJson(json).toJson(), settings.toJson());
    });
    // If add entry, not test => failed
    test("size of key = 1", () {
      Settings settings = Settings();
      expect(settings.toJson().keys.length, 1);
    });
  });
}
