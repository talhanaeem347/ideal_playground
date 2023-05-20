import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String labelText;
  final bool isBorder;
  const MyInputField({Key? key,
  required this.labelText,
  this.isBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
