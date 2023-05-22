import 'package:flutter/material.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class MyInputField extends StatelessWidget {
  final String label;
  final TextEditingController controllerText;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool isObscure;

  const MyInputField({
    Key? key,
    required this.controllerText,
    required this.label,
    this.validator,
    this.textInputType = TextInputType.text,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.white,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.yellow,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        style: TextStyle(color: AppColors.yellow, fontSize: 18),
        controller: controllerText,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        obscureText: isObscure,
        validator: validator ?? (value) => null,
      ),
    );
  }
}
