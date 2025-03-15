// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class CustomTextFrom extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final String? prefixText;
  final bool? withhint;
  final int? maxLines;
  final int? maxLength;
  final String? counterText;
  final bool? enabled;
  final VoidCallback? onTap;
  final bool? readOnly;
  final FocusNode? focusNode;

  const CustomTextFrom({
    super.key,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    required this.keyboardType,
    this.prefixText,
    this.withhint,
    this.maxLines,
    this.maxLength,
    this.counterText,
    this.enabled,
    this.onTap,
    this.readOnly,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withhint == true)
          Text(hintText!, style: Theme.of(context).textTheme.labelLarge!),
        if (withhint != null) verticalSpace(10),
        TextFormField(
          focusNode: focusNode,
          controller: controller,
          cursorColor: AppColors.mainColor,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
          obscureText: obscureText ?? false,
          validator: validator,
          enabled: enabled ?? true,
          readOnly: readOnly ?? false,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          keyboardType: keyboardType,
          onTap: onTap,
          decoration: InputDecoration(
            prefixIcon: prefixText != null
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 15, bottom: 15, left: 10),
                    child: Text(prefixText!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.lightBlue)),
                  )
                : null,
            filled: true,
            fillColor: AppColors.secondaryColor.withAlpha(10),
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: AppColors.lightBlue,
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.grey[100]!,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.lightRed,
              ),
            ),
            errorStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: AppColors.lightRed),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.mainColor.withAlpha(20),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.mainColor,
              ),
            ),
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      ],
    );
  }
}
