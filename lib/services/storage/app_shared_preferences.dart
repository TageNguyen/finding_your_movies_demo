import 'package:finding_your_movies_demo/enums/app_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  AppSharedPreferences._();

  static const String keyLanguage = 'keyLanguage';

  /// save [language] to local with [keyLanguage]
  static Future<bool> setLanguage(AppLanguage? language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(keyLanguage, '${language?.rawData}');
  }

  /// get an [AppLanguage] from [keyLanguage]
  static Future<AppLanguage> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rawData = prefs.getString(keyLanguage) ?? 'null';
    return AppLanguageEX.fromRawData(rawData);
  }
}
