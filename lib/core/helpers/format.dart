import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';

class Format {
  static String formatNumber(dynamic number, BuildContext context) {
    return NumberFormat.decimalPattern(
            LanguageChecker.isArabic(context) ? 'ar_EG' : 'en_US')
        .format(number);
  }

  static String formatNumberToDouble(dynamic number, BuildContext context) {
    return NumberFormat.decimalPattern(
            LanguageChecker.isArabic(context) ? 'ar_EG' : 'en_US')
        .format(number.toDouble());
  }

  static String formatPrice(dynamic price, BuildContext context) {
    return NumberFormat.currency(
            locale: LanguageChecker.isArabic(context) ? 'ar_EG' : 'en_US',
            symbol: 'appointments.EGP'.tr(),
            decimalDigits: 0)
        .format(price);
  }

  static String formatDate(DateTime date, BuildContext context) {
    return DateFormat(
            'dd-MM-yyyy', LanguageChecker.isArabic(context) ? 'ar_EG' : 'en_US')
        .format(date);
  }

  static String formatTime(DateTime date, BuildContext context) {
    return DateFormat(
            'hh:mm a', LanguageChecker.isArabic(context) ? 'ar_EG' : 'en_US')
        .format(date);
  }

  static String formatSringTime(String date, BuildContext context) {
    int hour = int.parse(date.split(':')[0]);
    int minute = int.parse(date.split(':')[1]);
    DateTime dateTime = DateTime(0, 0, 0, hour, minute);
    return DateFormat(
            'hh:mm a', LanguageChecker.isArabic(context) ? 'ar_EG' : 'en_US')
        .format(dateTime);
  }
}
