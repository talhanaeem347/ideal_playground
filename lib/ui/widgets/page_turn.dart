import 'package:flutter/material.dart';

void pageTurn({required BuildContext context, required Widget page,}) {
Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}