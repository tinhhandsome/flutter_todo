import 'dart:convert';

import 'package:flutter_todo/models/settings.dart';
import 'package:flutter_todo/sevices/locator.dart';
import 'package:flutter_todo/sevices/services.dart';

class SettingsRepository {
  Settings get settings {
    var value =
        locator<StorageDeviceService>().get(StorageDeviceService.settingsKey);
    if (value == null) {
      return Settings();
    }
    return Settings.fromJson(jsonDecode(value));
  }

  Future<bool> updateSetting(Settings settings) async {
    return locator<StorageDeviceService>()
        .set(StorageDeviceService.settingsKey, jsonEncode(settings.toJson()));
  }
}
