import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class DoctorCardOulinedButton extends StatelessWidget {
  const DoctorCardOulinedButton(
      {super.key,
      this.borderColor,
      required this.withIcon,
      required this.buttonName,
      this.icon});
  final Color? borderColor;
  final bool withIcon;
  final String buttonName;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.8,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor ?? AppColors.mainColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : SizedBox(),
          icon != null ? horizontalSpace(5) : horizontalSpace(0),
          Text(buttonName,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: borderColor ?? AppColors.mainColor))
        ],
      ),
    );
  }
}
