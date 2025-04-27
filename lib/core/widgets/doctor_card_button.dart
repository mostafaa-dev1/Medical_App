import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class DoctorCardButton extends StatelessWidget {
  const DoctorCardButton(
      {super.key, required this.buttonName, this.icon, this.color, this.onTap});
  final String buttonName;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
      ),
    );
  }
}
