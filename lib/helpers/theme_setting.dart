import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData themeSettings() {
  return ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.AppBarColor,
      ),
    ),
    dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    )),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
      color: AppColors.TextWhite,
    )),
    useMaterial3: true,
  );
}
