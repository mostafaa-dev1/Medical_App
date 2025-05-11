import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/theme_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class Default extends StatelessWidget {
  const Default({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/404.svg',
              width: 200,
              height: MediaQuery.of(context).size.width / 2,
            ),
            verticalSpace(50),
            Text(
              'default.exitApp'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalSpace(50),
            CustomButton(
                buttonName: 'default.no'.tr(),
                onPressed: () {
                  context.pushNamed(AppRoutes.mainScreen);
                },
                width: 200,
                paddingVirtical: 5,
                paddingHorizental: 10),
            verticalSpace(10),
            CustomButton(
                buttonName: 'default.yes'.tr(),
                onPressed: () {
                  exit(0);
                },
                buttonColor: ThemeChecker.isDark(context)
                    ? Colors.white
                    : AppColors.darkBlue,
                backgroundColor: AppColors.mainColor.withAlpha(20),
                width: 200,
                paddingVirtical: 5,
                paddingHorizental: 10),
          ],
        ),
      ),
    );
  }
}
