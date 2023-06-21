
import 'package:flutter/material.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class ThemeHelper{
  static bool isDarkMode = false;

  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.brown.shade500,
      foregroundColor: AppColors.yellow,
    ),
    primaryColor: Colors.brown.shade500,
    hintColor: AppColors.yellow,
    scaffoldBackgroundColor: Colors.brown.shade500,
    primarySwatch: AppColors.primarySwatch,

  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      foregroundColor: AppColors.yellow,
    ),
    primaryColor: AppColors.scaffoldBackgroundColor,
    hintColor: AppColors.yellow,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    primarySwatch: AppColors.primarySwatch,
  );





  static void toggleTheme(bool value){
    isDarkMode = value;
  }

  static get theme => isDarkMode ? darkTheme : lightTheme;

  static get isDarkModeOn => isDarkMode;

}