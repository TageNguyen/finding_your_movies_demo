import 'dart:io';

import 'package:finding_your_movies_demo/resource/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  /// dark theme
  static ThemeData get darkTheme {
    bool isAndroid = Platform.isAndroid;

    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      fontFamily: 'dejavu',
      platform: isAndroid ? TargetPlatform.android : TargetPlatform.iOS,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20.0,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18.0,
          height: 1.6,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
          height: 1.2,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24.0,
          height: 1,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
          height: 1,
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
          height: 1,
        ),
      ).apply(
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
        fontFamily: 'dejavu',
      ),
      bottomSheetTheme: bottomSheetTheme.copyWith(backgroundColor: AppColors.grey[100]),
      inputDecorationTheme: inputDecorationTheme.copyWith(
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18.0,
          height: 1.6,
          color: AppColors.white,
        ),
      ),
      appBarTheme: appBarTheme.copyWith(
        // AppBar background color
        color: AppColors.darkBackgroundColor,
        // Title textstyle
        titleTextStyle: appBarTheme.titleTextStyle?.copyWith(color: AppColors.white),
        // This will be applied to the "back" icon
        iconTheme: iconTheme.copyWith(color: AppColors.white),
        // This will be applied to the action icon buttons that locates on the right side
        actionsIconTheme: iconTheme.copyWith(color: AppColors.white),
      ),
      textSelectionTheme: textSelectedTheme.copyWith(cursorColor: AppColors.white),
      iconTheme: iconTheme.copyWith(color: AppColors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: elevatedButtonStyle,
      ),
      floatingActionButtonTheme: floatingActionButtonThemeData,
      listTileTheme: listTileThemeData,
    );
  }

  /// AppBarTheme
  static AppBarTheme appBarTheme = const AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'dejavu',
      fontWeight: FontWeight.w400,
      fontSize: 18.0,
      height: 1.6,
    ),
    toolbarTextStyle: TextStyle(
      fontFamily: 'dejavu',
      fontWeight: FontWeight.w400,
      fontSize: 18.0,
      height: 1.6,
    ),
    elevation: 0.0,
  );

  /// IconThemeData
  static BottomSheetThemeData bottomSheetTheme = const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
    ),
  );

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    isDense: true,
    contentPadding:
        const EdgeInsets.only(bottom: 12.0, top: 8.0, left: 10.0, right: 10.0),
    hintStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 18.0,
      height: 1.2,
      color: AppColors.grey[350],
    ),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(36.0),
      borderSide: BorderSide.none,
    ),
    focusColor: AppColors.grey[350],
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(36.0),
      borderSide: BorderSide.none,
    ),
    fillColor: AppColors.grey[350],
    filled: true,
  );

  static TextSelectionThemeData textSelectedTheme = const TextSelectionThemeData(
    cursorColor: AppColors.black,
  );

  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    alignment: Alignment.center,
    elevation: 0.0,
    padding: const EdgeInsets.fromLTRB(24.0, 14.0, 24.0, 14.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
      side: BorderSide.none,
    ),
    textStyle: const TextStyle(
      fontFamily: 'dejavu',
      fontWeight: FontWeight.w400,
      fontSize: 18.0,
      height: 1.2,
    ),
  );

  /// IconThemeData
  static IconThemeData iconTheme = const IconThemeData(
    size: 24.0,
  );

  static FloatingActionButtonThemeData floatingActionButtonThemeData =
      const FloatingActionButtonThemeData(
    foregroundColor: AppColors.white,
  );

  static ListTileThemeData listTileThemeData = const ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
  );
}
