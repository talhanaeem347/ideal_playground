import 'package:flutter/material.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

Widget iconWidget({icon, color, size, onTap }) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.white.withOpacity(0.6), // Replace with your desired gray color
      borderRadius: BorderRadius.circular(8), // Adjust the border radius as needed
    ),
    child: IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: color,
        size: size,
      ),
    ),
  );

}