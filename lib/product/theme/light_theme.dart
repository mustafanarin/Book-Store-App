import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:flutter/material.dart';

class LightTheme{

  ThemeData theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ProjectColors.white,
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: ProjectColors.white,
      //shadowColor: ProjectColors.maWhite,
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
                  labelStyle: TextStyle(color: ProjectColors.cosmicVoid,fontWeight: FontWeight.w400),
                  
                  suffixIconColor: ProjectColors.grey,
                  prefixIconColor: ProjectColors.grey
    ),
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(width: 2,color: ProjectColors.majoreBlue),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w700,
        fontSize: 20,
        height: 27.32 / 20, // line height / font size
        color: Color.fromRGBO(9, 9, 55, 1),
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 21.86 / 16,
        color: Color.fromRGBO(9, 9, 55, 0.6),
      ),
      titleMedium: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 21.86 / 16,
        color: Color.fromRGBO(9, 9, 55, 0.4),
      ),
      titleSmall: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w700,
        fontSize: 12,
        height: 16.39 / 12,
        color: Color.fromRGBO(98, 81, 221, 1),
      ),
      labelLarge: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w600,
        fontSize: 12,
        height: 16.39 / 12,
        color: Color.fromRGBO(9, 9, 55, 1),
      ),
      labelMedium: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w600,
        fontSize: 10,
        height: 13.66 / 12,
        color: Color.fromRGBO(9, 9, 55, 0.6),
      ),
      labelSmall: TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w600,
        fontSize: 8,
        height: 10.93 / 12,
        color: Color.fromRGBO(9, 9, 55, 0.6),
      ),
    ),
  );
}