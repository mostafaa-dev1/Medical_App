import 'package:flutter/material.dart';

class ThemeChecker {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
