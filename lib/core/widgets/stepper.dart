import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class AppointmentStepper extends StatelessWidget {
  const AppointmentStepper(
      {super.key, required this.index, required this.text});
  final int index;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'appointments.selectDateAndTime'.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 12, color: AppColors.mainColor),
                    ),
                    verticalSpace(8),
                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(5),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'appointments.patientDetails'.tr(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 12,
                          color: index == 1 || index == 2
                              ? AppColors.mainColor
                              : Theme.of(context).cardColor),
                    ),
                    verticalSpace(8),
                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: index == 1 || index == 2
                            ? AppColors.mainColor
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(5),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'summary.reviewSummary'.tr(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            color: index == 2
                                ? AppColors.mainColor
                                : Theme.of(context).cardColor,
                          ),
                    ),
                    verticalSpace(8),
                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: index == 2
                            ? AppColors.mainColor
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
