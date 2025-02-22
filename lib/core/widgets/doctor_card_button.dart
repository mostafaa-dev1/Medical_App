import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class DoctorCardButton extends StatelessWidget {
  const DoctorCardButton(
      {super.key, required this.buttonName, this.icon, this.color});
  final String buttonName;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color ?? AppColors.mainColor,
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
                  .labelMedium!
                  .copyWith(color: Colors.white))
        ],
      ),
    );
  }
}
