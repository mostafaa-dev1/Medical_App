import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/themes/colors.dart';

class UserMessage extends StatelessWidget {
  const UserMessage({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: LanguageChecker.isArabic(context)
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: LanguageChecker.isArabic(context)
                ? Radius.zero
                : Radius.circular(20),
            bottomRight: LanguageChecker.isArabic(context)
                ? Radius.circular(20)
                : Radius.zero,
          ),
          color: AppColors.secondaryColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(message,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white)),
      ),
    );
  }
}
