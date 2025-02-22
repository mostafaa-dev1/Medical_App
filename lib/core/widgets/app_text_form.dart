// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
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
    return TextFormField(
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
      keyboardType: keyboardType,
      onTap: onTap,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppColors.lightBlue,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
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
    );
  }
}
