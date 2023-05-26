import 'package:flutter/material.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class SimpleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final String label;
  final Color color;
  final Color textColor;
   const SimpleButton({Key? key, required this.onPressed, required this.width, required this.height, required this.label, required this.color, required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,

      child: Container(
          // padding: const EdgeInsets.symmetric(vertical: 15),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          )),
    );
  }
}
