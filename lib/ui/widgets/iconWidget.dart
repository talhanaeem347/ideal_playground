import 'package:flutter/material.dart';

Widget iconWidget({icon, color, size, onTap }) {
  return IconButton(
    onPressed: onTap,
    icon: Icon(
      icon,
      color: color,
      size: size,
    ),
  );
}