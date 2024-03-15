/* Types of language of this app 
*/
import 'package:flutter/material.dart';

enum AppLanguage { english }

extension AppLanguageEX on AppLanguage {
  static AppLanguage fromRawData(String rawData) {
    switch (rawData) {
      case 'english':
        return AppLanguage.english;
      default:
        return AppLanguage.english;
    }
  }

  String get rawData {
    switch (this) {
      case AppLanguage.english:
        return 'english';
      default:
        return 'unknown';
    }
  }

  /// return a locale based on [AppLanguage]
  Locale toLocale() {
    switch (this) {
      case AppLanguage.english:
        return const Locale('en');
      default:
        return const Locale('en');
    }
  }
}
