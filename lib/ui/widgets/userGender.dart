import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

Widget userGender(gender) {
  switch (gender) {
    case "Male":
      return Icon(
        FontAwesomeIcons.mars,
        color: AppColors.yellow,
        size: 20,
      );
    case "Female":
      return Icon(
        FontAwesomeIcons.venus,
        color: AppColors.yellow,
        size: 20,
      );
    default:
      return Icon(
        FontAwesomeIcons.marsAndVenus,
        color: AppColors.yellow,
        size: 20,
      );

  }
}
