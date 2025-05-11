import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/features/laboratories/data/model/labs_model.dart';

String addressBuilder(
    Address address, String city, String government, BuildContext context) {
  bool isArabic = LanguageChecker.isArabic(context);
  return isArabic
      ? '${'government.$government'.tr()} | ${'city.$city'.tr()} | ${address.streatAr} | ${address.buildingAr} | ${address.signAr} | ${address.floorAr}'
      : '${'government.$government'.tr()} | ${'city.$city'.tr()} | ${address.streat} | ${address.building} | ${address.sign} | ${address.floor}';
}
