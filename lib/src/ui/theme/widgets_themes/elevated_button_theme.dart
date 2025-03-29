import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../font_family.dart';

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return primaryColor;
          }

          return primaryColor;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return primaryColor;
          }

          // disabledTextColor == null
          //     ? Colors.black
          //     : disabledTextColor!;

          return whiteColor;

          // disabledTextColor == null
          //     ? Colors.black
          //     : disabledTextColor!;
        },
      ),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return TextStyle(fontSize: 17, fontFamily: FontFamily.regular);
          }

          return TextStyle(fontSize: 17, fontFamily: FontFamily.regular);
        },
      ),
      shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            );
          }

          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          );
        },
      ),
      minimumSize: MaterialStateProperty.resolveWith<Size>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Size(double.infinity, 50.0);
          }

          return Size(double.infinity, 50.0);
        },
      ),
    ),
  );
}
