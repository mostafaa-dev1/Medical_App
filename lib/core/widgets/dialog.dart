import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.isError, required this.message});
  final bool isError;
  final String message;

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
                'assets/images/dialog/error.svg',
                height: 200,
              ),
              verticalSpace(20),
              Text(
                'dialog.oops'.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              verticalSpace(10),
              Text(
                message,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              verticalSpace(20),
              CustomButton(
                  backgroundColor:
                      isError ? AppColors.lightRed : AppColors.secondaryColor,
                  buttonName: 'dialog.ok'.tr(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  width: 100,
                  paddingVirtical: 10,
                  paddingHorizental: 20)
            ],
          ),
        ),
      ),
    );
  }
}
