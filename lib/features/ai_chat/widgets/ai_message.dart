import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/themes/colors.dart';

class AiMessage extends StatelessWidget {
  const AiMessage(
      {super.key,
      required this.message,
      required this.loading,
      required this.type});
  final String message;
  final String type;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: LanguageChecker.isArabic(context)
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: LanguageChecker.isArabic(context)
                ? Radius.zero
                : Radius.circular(20),
            bottomLeft: LanguageChecker.isArabic(context)
                ? Radius.circular(20)
                : Radius.zero,
          ),
          color: AppColors.secondaryColor.withAlpha(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: loading
            ? LoadingAnimationWidget.waveDots(
                color: AppColors.mainColor, size: 18)
            : Text(
                type == 'Spciality'
                    ? '${'home.youNeed'.tr()} ${'specialities.$message'.tr()}'
                    : message,
                style: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }
}
