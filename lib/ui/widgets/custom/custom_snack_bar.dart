import 'package:flutter/material.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

void showMessage(BuildContext context, String message,
    {bool isError = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: AppColors.transparent,
        content: Container(
          height: 80,
          width: 300,
          decoration: BoxDecoration(
            color: isError ? AppColors.red : AppColors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                )),
          ),
        ),
      ),
    );
}
