
import 'package:flutter/material.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';

class PickDate {
  static Future<DateTime?> getDate(BuildContext context,DateTime initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: AppStrings.minDate,
      lastDate: AppStrings.maxDate,
    );
    return picked;
  }
}