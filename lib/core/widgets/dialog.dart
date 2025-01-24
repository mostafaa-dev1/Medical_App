import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class CustonDialog extends StatelessWidget {
  const CustonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Dialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)), //this right here
        child: SizedBox(
          height: 400.0,
          width: 350.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/dialog/user_dialog.svg',
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Auth.login'.tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Text(
                'Auth.pleaseWait'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              verticalSpace(20),
              const CircularProgressIndicator(
                color: AppColors.secondaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
