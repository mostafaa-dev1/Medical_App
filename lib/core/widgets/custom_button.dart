import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final double width;
  final double? height;

  final double paddingVirtical;
  final double paddingHorizental;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? buttonColor;
  final double? borderRadius;
  final bool? withBorderSide;
  final bool? isLoading;
  final IconData? icon;
  final double? iconSize;
  final bool? reightIcon;

  const CustomButton(
      {super.key,
      required this.buttonName,
      required this.onPressed,
      required this.width,
      required this.paddingVirtical,
      required this.paddingHorizental,
      this.fontSize,
      this.backgroundColor,
      this.buttonColor,
      this.borderRadius,
      this.withBorderSide,
      this.isLoading,
      this.height,
      this.icon,
      this.iconSize,
      this.reightIcon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(
                horizontal: paddingHorizental.w, vertical: paddingVirtical.h),
          ),
          minimumSize:
              WidgetStateProperty.all<Size>(Size(width.w, height ?? 40.h)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
                side: BorderSide(
                  color: withBorderSide ?? false
                      ? backgroundColor ?? AppColors.mainColor
                      : Colors.transparent,
                )),
          ),
          backgroundColor: WidgetStateProperty.all(withBorderSide ?? false
              ? Colors.transparent
              : backgroundColor ?? AppColors.mainColor)),
      onPressed: isLoading ?? false ? null : onPressed,
      child: isLoading ?? false
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.threeArchedCircle(
                  color: buttonColor ?? Colors.white,
                  size: 23,
                ),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon != null && reightIcon == false
                    ? Icon(
                        icon,
                        size: iconSize ?? 18,
                        color: buttonColor ?? Colors.white,
                      )
                    : const SizedBox(),
                icon != null && reightIcon == false
                    ? horizontalSpace(5)
                    : horizontalSpace(0),
                Text(buttonName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: buttonColor ?? Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize ?? 16.sp,
                        )),
                icon != null && reightIcon == true
                    ? horizontalSpace(5)
                    : horizontalSpace(0),
                icon != null && reightIcon == true
                    ? Icon(
                        icon,
                        size: iconSize ?? 18,
                        color: buttonColor ?? Colors.white,
                      )
                    : const SizedBox(),
              ],
            ),
    );
  }
}
