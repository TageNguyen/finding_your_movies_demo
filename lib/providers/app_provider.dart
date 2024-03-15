import 'package:finding_your_movies_demo/enums/app_language.dart';
import 'package:finding_your_movies_demo/services/storage/app_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/* This class handles app state include loading state, language, etc
 */
class AppProvider with ChangeNotifier {
  AppProvider() {
    _initialize();
  }

  /// manage app state
  final _loadingObject = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get loadingStream => _loadingObject.stream;

  /// manage app language
  AppLanguage? _language;
  AppLanguage? get language => _language;

  /// change app language to [language]
  void changeLanguage(AppLanguage language) {
    _language = language;
    AppSharedPreferences.setLanguage(language);
    notifyListeners();
  }

  /// initialize app provider
  /// getting current app language
  void _initialize() async {
    AppLanguage language = await AppSharedPreferences.getLanguage();
    changeLanguage(language);
  }

  /// show loading status above app ui
  void showLoading() {
    _loadingObject.add(true);
    notifyListeners();
  }

  /// hide loading status
  void hideLoading() {
    _loadingObject.add(false);
    notifyListeners();
  }
}
