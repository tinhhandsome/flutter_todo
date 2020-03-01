class Settings {
  int themeMode;
  String languageCode;

  Settings({this.themeMode = 1, this.languageCode = "en"});

  Settings.fromJson(Map<String, dynamic> json) {
    themeMode = json['theme_mode'];
    languageCode = json['language_code'] ?? "en";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['theme_mode'] = themeMode;
    data['language_code'] = languageCode ?? "en";
    return data;
  }
}
