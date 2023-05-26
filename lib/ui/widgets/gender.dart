
import 'package:flutter/cupertino.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

Widget genderWidget(icon,text,size,selected,onTap){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: size.width * 0.28,
      height: size.height * 0.16,
      padding: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: selected == text ? AppColors.grey.withOpacity(0.3)  : AppColors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5)  ,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.grey ,
            size: size.width * 0.2,
          ),
          SizedBox(
            height: size.height * 0.008,
          ),
          Text(
            text,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}