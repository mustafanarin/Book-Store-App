import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:flutter/material.dart';

class LightTheme{

  ThemeData theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ProjectColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: ProjectColors.white,
      shadowColor: ProjectColors.maWhite,
      toolbarHeight: kToolbarHeight + VisualDensity.maximumDensity
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
      )
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(color: Colors.transparent)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(color: Colors.transparent)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(color: ProjectColors.majoreBlue)
                ),
                  filled: true,
                  fillColor: ProjectColors.maWhite,
                  hintStyle: TextStyle(color: ProjectColors.grey,fontWeight: FontWeight.w400),
                  suffixIconColor: ProjectColors.grey,
                  prefixIconColor: ProjectColors.grey
    ),
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(width: 2,color: ProjectColors.majoreBlue),
    ),
  );
}