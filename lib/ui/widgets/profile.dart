import 'package:flutter/material.dart';
import 'package:ideal_playground/ui/widgets/photo.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

Widget profileWidget({size,
   photoUrl, child}) {
  return Padding(
    padding: EdgeInsets.all(size.width * 0.02),
    child: Container(
      height: size.height * 0.8,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(10, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: size.height * 0.8,
            width: size.width * 0.9,
            child: ClipRRect(
              borderRadius:  BorderRadius.circular(20),
              child:PhotoWidget(photoUrl: photoUrl),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight:  Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.transparent,
                  AppColors.black.withOpacity(0.2),
                  AppColors.black.withOpacity(0.5),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
              color: AppColors.black.withOpacity(0.45),
            ),
            width: size.width * 0.9,
            height: size.height * 0.8,
            child: child,
          )
        ],
      ),
    )
  );
}