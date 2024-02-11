import 'package:flutter/material.dart';

class AppTheme {
  ///colors
  static const Color primaryColor = Color(0xFFDC6465);

  static MaterialColor primarySwatch = MaterialColor(Color(0xFFDC6465).value, {
    50: const Color(0xFFDC6465).withOpacity(.05),
    100: const Color(0xFFDC6465).withOpacity(.1),
    200: const Color(0xFFDC6465).withOpacity(.2),
    300: const Color(0xFFDC6465).withOpacity(.3),
    400: const Color(0xFFDC6465).withOpacity(.4),
    500: const Color(0xFFDC6465).withOpacity(.5),
    600: const Color(0xFFDC6465).withOpacity(.6),
    700: const Color(0xFFDC6465).withOpacity(.7),
    800: const Color(0xFFDC6465).withOpacity(.8),
    900: const Color(0xFFDC6465).withOpacity(.9)
  });

  static const Color secondaryColor = Color(0xFFFFFFFF);
  static MaterialColor secondarySwitch =
      MaterialColor(Color(0xFFFFFFFF).value, {
    50: const Color(0xFFFFFFFF).withOpacity(.05),
    100: const Color(0xFFFFFFFF).withOpacity(.1),
    200: const Color(0xFFFFFFFF).withOpacity(.2),
    300: const Color(0xFFFFFFFF).withOpacity(.3),
    400: const Color(0xFFFFFFFF).withOpacity(.4),
    500: const Color(0xFFFFFFFF).withOpacity(.5),
    600: const Color(0xFFFFFFFF).withOpacity(.6),
    700: const Color(0xFFFFFFFF).withOpacity(.7),
    800: const Color(0xFFFFFFFF).withOpacity(.8),
    900: const Color(0xFFFFFFFF).withOpacity(.9)
  });

  static Color scaffoldBackgroundColor = Color(0xffFFFFFF);
  static Color scaffoldBackgroundColor2 = Color(0xffF6F9FF);

  static String fontFamily = 'Alhurra';

  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 18.0,
      fontFamily: fontFamily,
      color: Colors.brown,
    ),
    displayMedium:
        TextStyle(fontSize: 16.0, fontFamily: fontFamily, color: Colors.brown),
    displaySmall:
        TextStyle(fontSize: 14, fontFamily: fontFamily, color: Colors.brown),
    headlineMedium: TextStyle(
        fontSize: 14, fontFamily: fontFamily, color: AppTheme.primaryColor),
    headlineSmall:
        TextStyle(fontSize: 12.0, fontFamily: fontFamily, color: Colors.brown),
    titleLarge: TextStyle(
        fontSize: 12.0, fontFamily: fontFamily, color: AppTheme.primaryColor),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontFamily: fontFamily,
      color: Colors.white,
    ),
    bodyMedium:
        TextStyle(fontSize: 20.0, fontFamily: fontFamily, color: Colors.white),
  );
}
