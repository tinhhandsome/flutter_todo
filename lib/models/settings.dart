class Settings {
  int themeMode;

  Settings({this.themeMode = 1});

  Settings.fromJson(Map<String, dynamic> json) {
    themeMode = json['theme_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['theme_mode'] = themeMode;
    return data;
  }
}
