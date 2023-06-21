import 'package:flutter/material.dart';

Future<void> pageTurn({required BuildContext context, required Widget page,}) async {
Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}