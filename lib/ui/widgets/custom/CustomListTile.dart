import 'package:flutter/material.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class CustomListTile extends StatelessWidget {
  final String? leadingImage;
  final IconData? leadingIcon;
  final String title;
  final Widget? trailing;
  final Function()? onTap;
  final Size size;
  final IconData? trailingIcon;
  final Color? leadingColor;

  const CustomListTile({
    super.key,
    this.leadingImage,
    this.leadingIcon,
    required this.title,
    this.trailing,
    this.onTap,
    required this.size, this.trailingIcon, this.leadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: ListTile(
        leading: leadingImage != null
            ? CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(leadingImage!),
              )
            : Icon(
                leadingIcon,
                size: 30,
                color: leadingColor ?? AppColors.black,
              ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
        ),
        trailing: trailing ?? IconButton(
          onPressed: onTap,
          icon: Icon(
            trailingIcon,
            color: AppColors.black,
          ),
        )

      ),
    );
  }
}
