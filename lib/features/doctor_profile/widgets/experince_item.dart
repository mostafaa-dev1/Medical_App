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
          radius: 30,
          backgroundColor: AppColors.secondaryColor.withAlpha(30),
          child: Icon(
            icon,
            size: 27,
            color: AppColors.mainColor,
          ),
        ),
        verticalSpace(10),
        Text(
          amount,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.mainColor),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: AppColors.lightBlue),
        ),
      ],
    );
  }
}
