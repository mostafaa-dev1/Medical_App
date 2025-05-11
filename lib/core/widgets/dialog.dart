import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

void showCustomDialog({
  required BuildContext context,
  required String message,
  required String title,
  required VoidCallback onConfirmPressed,
  VoidCallback? onCancel,
  required String confirmButtonName,
  String? cancelButtonName,
  bool? withTowButtons,
  required DialogType dialogType,
  Color? color,
  bool? barrierDismissible,
}) {
  showDialog(
    barrierDismissible: barrierDismissible ?? true,
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
        message: message,
        title: title,
        onConfirmPressed: onConfirmPressed,
        confirmButtonName: confirmButtonName,
        cancelButtonName: cancelButtonName,
        withTowButtons: withTowButtons,
        dialogType: dialogType,
        color: color,
      );
    },
  );
}

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.dialogType,
      required this.message,
      required this.confirmButtonName,
      required this.title,
      this.withTowButtons,
      this.color,
      this.cancelButtonName,
      required this.onConfirmPressed});
  final String message;
  final VoidCallback onConfirmPressed;
  final bool? withTowButtons;
  final Color? color;
  final String confirmButtonName;
  final DialogType dialogType;
  final String title;
  final String? cancelButtonName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: 420.0,
        width: 350.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/dialog/${dialogType.name}.svg',
                height: 200,
              ),
              verticalSpace(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    verticalSpace(10),
                    Text(
                      textAlign: TextAlign.center,
                      message,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  withTowButtons ?? false
                      ? CustomButton(
                          height: 35,
                          buttonColor: dialogType == DialogType.error
                              ? AppColors.lightRed
                              : AppColors.mainColor,
                          withBorderSide: true,
                          backgroundColor: dialogType == DialogType.error
                              ? AppColors.lightRed
                              : AppColors.mainColor,
                          buttonName: cancelButtonName ?? 'dialog.cancel'.tr(),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          width: 80,
                          paddingVirtical: 0,
                          paddingHorizental: 20)
                      : SizedBox(),
                  horizontalSpace(10),
                  CustomButton(
                      height: 35,
                      backgroundColor: dialogType == DialogType.error
                          ? AppColors.lightRed
                          : AppColors.mainColor,
                      buttonName: confirmButtonName,
                      onPressed: onConfirmPressed,
                      width: 80,
                      paddingVirtical: 0,
                      paddingHorizental: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum DialogType {
  error,
  success,
  warning,
  apppintment,
  sent,
}
