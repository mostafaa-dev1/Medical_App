import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/themes/colors.dart';

class DayesLoading extends StatelessWidget {
  const DayesLoading({super.key, required this.workTimes});
  final WorkTimes workTimes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.appWidth(context) > 600 &&
                Responsive.appWidth(context) < 800
            ? 5
            : Responsive.appWidth(context) < 600
                ? 3
                : 6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.4,
      ),
      itemCount: 12,
      itemBuilder: (context, index) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.mainColor.withAlpha(20),
        ),
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('appointments.day'.tr(), // Day names
                style: Theme.of(context).textTheme.labelSmall!),
            Text('dayNumber', // Day numbers
                style: Theme.of(context).textTheme.labelSmall!),
            Text('monthName'.tr(), // Month names
                style: Theme.of(context).textTheme.labelSmall!),
          ],
        ),
      ),
    );
  }
}
