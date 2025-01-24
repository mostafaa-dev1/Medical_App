import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_system/core/themes/colors.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
    required this.languageIndex,
    required this.title,
    required this.buttonIndex,
    required this.onPressed,
  });
  final int languageIndex;
  final String title;
  final int buttonIndex;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        alignment: Alignment.center,
        fixedSize: WidgetStateProperty.all<Size>(
            Size(MediaQuery.of(context).size.width / 1.3, 50)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                width: languageIndex == buttonIndex ? 2 : 1,
                color: languageIndex == buttonIndex
                    ? AppColors.mainColor
                    : Colors.grey[200]!,
              )),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: buttonIndex == 0
            ? Row(
                textDirection: ui.TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.almarai(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: languageIndex == buttonIndex
                                    ? AppColors.mainColor
                                    : AppColors.darkBlue,
                              ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: languageIndex == buttonIndex
                        ? AppColors.mainColor
                        : Colors.grey[200],
                    child: Icon(
                      Icons.check,
                      color: languageIndex == buttonIndex
                          ? Colors.white
                          : AppColors.secondaryColor,
                      size: 20,
                    ),
                  ),
                ],
              )
            : Row(
                textDirection: ui.TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: languageIndex == buttonIndex
                        ? AppColors.mainColor
                        : Colors.grey[200],
                    child: Icon(
                      Icons.check,
                      color: languageIndex == buttonIndex
                          ? Colors.white
                          : AppColors.secondaryColor,
                      size: 20,
                    ),
                  ),
                  Text(
                    title,
                    style: GoogleFonts.almarai(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: languageIndex == buttonIndex
                                    ? AppColors.mainColor
                                    : AppColors.darkBlue,
                              ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
