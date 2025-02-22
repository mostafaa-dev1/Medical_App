import 'package:flutter/material.dart';

class Responsive {
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 500;
  }

  static double appWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double appHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
