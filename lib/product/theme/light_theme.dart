import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:flutter/material.dart';

class LightTheme{

  ThemeData theme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: ProjectColors.white,
      shadowColor: ProjectColors.maWhite,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
      )
    )
  );
}