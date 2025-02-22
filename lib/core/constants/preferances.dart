import 'package:flutter/material.dart';

class AppPreferances {
  static const String imagePath = 'assets/images/';
  static const String onboardingImagePath = 'assets/images/onboard/';
  static const String dialogImagePath = 'assets/images/dialog/';
  static const double padding = 20;
  static const double borderRadius = 20;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
