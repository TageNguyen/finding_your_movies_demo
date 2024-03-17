import 'dart:convert';

import 'package:finding_your_movies_demo/enums/app_language.dart';
import 'package:finding_your_movies_demo/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  AppSharedPreferences._();

  static const String keyLanguage = 'keyLanguage';
  static const String keyUserData = 'keyUserData';
  static const String keySavedMovieIds = 'keySavedMovies';

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

  /// save [userData] to local with [keyUserData]
  static Future<bool> setLocalUserData(User? userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(keyUserData, jsonEncode(userData?.toJson()));
  }

  /// get user data from [keyUserData]
  static Future<User?> getLocalUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rawData = prefs.getString(keyUserData) ?? 'null';
    return rawData != 'null' ? User.fromJson(jsonDecode(rawData)) : null;
  }

  /// save [movieIds] list to local with [keySavedMovieIds] based on [userId]
  static Future<bool> setSavedMovieIds(String userId, List<String> movieIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(movieIds.map<String>((id) => id).toList());
    return await prefs.setString('$keySavedMovieIds $userId', data);
  }

  /// get local movieIds list from [keySavedMovieIds] based on [userId]
  static Future<List<String>> getSavedMovieIds(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final stringData = prefs.getString('$keySavedMovieIds $userId') ?? '[]';
    return (jsonDecode(stringData) as List).map<String>((id) => id).toList();
  }
}
