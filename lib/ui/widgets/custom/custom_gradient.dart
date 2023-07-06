
import 'package:flutter/material.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class CustomGradient extends StatelessWidget {
  final Widget child;
  const CustomGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
    AppColors.scaffoldBackgroundColor,
    AppColors.white
    ])),
    alignment: Alignment.center,
    child: child,
    );
  }
}
