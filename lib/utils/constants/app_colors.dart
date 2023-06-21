import 'package:flutter/material.dart';
import 'package:ideal_playground/helpers/theme_helper.dart';

class AppColors{
  static bool get isDarkModeOn => ThemeHelper.isDarkModeOn;

  static AppColors i = AppColors();
  static Color get blue =>  Colors.blue;
  static Color get black => Colors.black;
  static Color get red => Colors.red;
  static Color get green => Colors.green;
  static Color get grey => Colors.grey  ;
  static Color get white => isDarkModeOn ? Colors.grey :  Colors.white;
  static Color get yellow => isDarkModeOn? Colors.yellow.withOpacity(0.5) : Colors.yellow ;
  static Color get transparent => Colors.transparent;
  static MaterialColor get primarySwatch =>  Colors.blue;

  static Color get scaffoldBackgroundColor => ThemeHelper.isDarkModeOn ? const Color(0xFF021229) :  Colors.brown.shade500;


}