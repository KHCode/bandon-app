import 'package:flutter/material.dart';

BoxDecoration gradientBackground(BuildContext context) {
  List<Color> gradientColors = Theme.of(context).brightness == Brightness.light
      ? [Colors.white70, Color(0xFFF0F3BD)]
      : [Color(0xFF2F5570), Colors.black];

  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: gradientColors,
    ),
  );
}
