import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageChecker {
  static bool isEnglish(BuildContext context) {
    return context.locale == Locale('en');
  }

  static bool isArabic(BuildContext context) {
    return context.locale == Locale('ar');
  }
}
