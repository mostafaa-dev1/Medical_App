import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class ExperinceItem extends StatelessWidget {
  const ExperinceItem(
      {super.key,
      required this.title,
      required this.amount,
      required this.icon});
  final String title;
  final String amount;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: AppColors.secondaryColor.withAlpha(30),
          child: Icon(
            icon,
            size: 30,
            color: AppColors.mainColor,
          ),
        ),
        verticalSpace(10),
        Text(
          amount,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: AppColors.mainColor),
        ),
        verticalSpace(5),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: AppColors.lightBlue),
        ),
      ],
    );
  }
}
