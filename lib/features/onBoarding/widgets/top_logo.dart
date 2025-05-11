import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';

class TopLogo extends StatelessWidget {
  const TopLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: ui.TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/logo.svg',
          height: 20,
          width: 20,
        ),
        horizontalSpace(7),
        Text('Delma',
            style: GoogleFonts.nunito(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.mainColor,
            )),
        Spacer(),
        TextButton(
          onPressed: () {
            context.pushNamed(AppRoutes.login);
          },
          child: Text(
            'Skip',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.mainColor,
                ),
          ),
        )
      ],
    );
  }
}
