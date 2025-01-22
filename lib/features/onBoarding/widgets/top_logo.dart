import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_system/core/helpers/spacing.dart';
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
          height: 30,
          width: 30,
        ),
        horizontalSpace(7),
        Text('Delma',
            style: GoogleFonts.nunito(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            )),
        Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            'Skip',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.secondaryColor,
                ),
          ),
        )
      ],
    );
  }
}
