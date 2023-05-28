import 'package:flutter/material.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

void showCircularProgress(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: AppColors.transparent,
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
}

void showFailureTos(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: AppColors.transparent,
        content: SizedBox(

          height: MediaQuery.of(context).size.height * 0.9,
          child: Center(
            child: Container(
              height: 80,
              width: 300,
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(AppStrings.failureMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ),
    );
}
