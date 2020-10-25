import 'package:flutter/material.dart';

BoxDecoration gradientBackground() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF05668d), Color(0xFFf0f3bd)],
    ),
  );
}
