import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'font_family.dart';
import 'widgets_themes/elevated_button_theme.dart';

final ThemeData appThemeData = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.light,
  primaryColor: primaryColor,
  elevatedButtonTheme: elevatedButtonTheme(),
  hintColor: greyColor,
  scaffoldBackgroundColor: Colors.grey[100],
  canvasColor: whiteColor,
  // Define the default font family.
  fontFamily: FontFamily.medium,

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 72.0,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    titleLarge: TextStyle(
      fontSize: 36.0,
      fontFamily: 'Poppins',
      fontStyle: FontStyle.italic,
      color: textColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Poppins',
      color: textColor,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: Colors.grey,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: primaryColor,
    colorScheme: ColorScheme(
      background: primaryColor,
      brightness: Brightness.light,
      error: Colors.red,
      onBackground: primaryColor,
      primary: primaryColor,
      onError: whiteColor,
      onPrimary: whiteColor,
      onSecondary: whiteColor,
      secondary: secondaryColor,
      onSurface: whiteColor,
      surface: primaryColor,
    ),
  ),
);
