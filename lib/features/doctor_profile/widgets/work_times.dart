import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/themes/colors.dart';

class WorkTimesList extends StatelessWidget {
  const WorkTimesList({super.key, required this.workTimes});
  final WorkTimes workTimes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'doctorProfile.workingTime'.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        verticalSpace(10),
        ...List.generate(workTimes.workTimes!.length, (index) {
          var workTime = workTimes.workTimes![index];
          return Row(children: [
            Text(
              'appointments.${workTime.day}'.tr(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            horizontalSpace(5),
            Text(
              '${'appointments.from'.tr()} ',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColors.lightBlue,
                  ),
            ),
            horizontalSpace(5),
            Text(parseDateTime(workTime.start!, context),
                style: Theme.of(context).textTheme.bodySmall),
            horizontalSpace(5),
            Text(
              '${'appointments.to'.tr()} ',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColors.lightBlue,
                  ),
            ),
            Text(parseDateTime(workTime.end!, context),
                style: Theme.of(context).textTheme.bodySmall)
          ]);
        }),
      ],
    );
  }
  //'${'appointments.${workTime.day{super.key}{super.key}{super.key}{super.key}}'.tr()} | ${parseDateTime(workTime.start!, workTime.end!, context)}',

  String parseDateTime(DateTime dateTime, BuildContext context) {
    //log(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString).toString());
    String date = Format.formatTime(dateTime, context);
    return date;
  }
}
