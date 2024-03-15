import 'package:flutter/material.dart';

class AppColors {
  static const black = Color(0xff000000);
  static const white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);
  static const darkBackgroundColor = Color.fromARGB(255, 7, 4, 15);

  static const MaterialColor purple = MaterialColor(
    0xFF5C24FF,
    <int, Color>{
      100: Color(0xFFDFD4FF),
      200: Color(0xFFCCBAFF),
      300: Color(0xFFDFD5FE),
      400: Color(0xFFBBA4FF),
      500: Color(0xFFA688FF),
      600: Color(0xFF885FFF),
      700: Color(0xFF6E46E0),
      800: Color(0xFF5C24FF),
      900: Color(0xFF473D64),
    },
  );

  static const MaterialColor grey = MaterialColor(
    0xFF9E9E9E,
    <int, Color>{
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF4F3F5),
      200: Color(0xFFEEEEEE),
      300: Color(0xFF94A3B8),
      350: Color(0xFFD6D6D6), // only for raised button while pressed in light theme
      400: Color(0xFFBDBDBD),
      500: Color(0xFF9E9E9E),
      600: Color(0xFF757575),
      700: Color(0xFF616161),
      800: Color(0xFF424242),
      850: Color(0xFF303030), // only for background color in dark theme
      900: Color(0xFF212121),
    },
  );
}
