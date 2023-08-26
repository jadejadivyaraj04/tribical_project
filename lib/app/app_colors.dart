import 'package:flutter/material.dart';

// All app colors are defined here
class AppColors {
  AppColors._();

  static MaterialColor primaryPalette = MaterialColor(
    colorED7844.value,
    <int, Color>{
      50: colorED7844.withAlpha(10),
      100: colorED7844.withAlpha(20),
      200: colorED7844.withAlpha(30),
      300: colorED7844.withAlpha(40),
      400: colorED7844.withAlpha(50),
      500: colorED7844.withAlpha(60),
      600: colorED7844.withAlpha(70),
      700: colorED7844.withAlpha(80),
      800: colorED7844.withAlpha(90),
      900: colorED7844.withAlpha(100),
    },
  );

  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorBlack = Color(0xFF000000);
  static const Color colorShadow = Color(0x00000029);

  static const Color colorED7844 = Color(0xFFED7844);
  static const Color colorF6F6F6 = Color(0xFFF6F6F6);
  static const Color color3B4860 = Color(0xFF3B4860);
  static const Color colorA9A9A9 = Color(0xFFA9A9A9);

}

