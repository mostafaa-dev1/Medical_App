import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required this.clinic, required this.user});
  final Clinic clinic;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.map, arguments: clinic);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, top: 10, bottom: 0, right: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                        color: AppColors.mainColor,
                      )),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: clinic.doctor!.image != null ||
                              clinic.doctor!.image! != ' '
                          ? Image(
                              image: NetworkImage(clinic.doctor!.image!),
                              fit: BoxFit.fill,
                            )
                          : Image(
                              image: AssetImage('assets/images/doctor.png'),
                              fit: BoxFit.fill,
                            )),
                ),
                horizontalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'appointments.dr'.tr()} ${LanguageChecker.isArabic(context) ? clinic.doctor!.firstNameAr : clinic.doctor!.firstName} ${LanguageChecker.isArabic(context) ? clinic.doctor!.lastNameAr : clinic.doctor!.lastName}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'specialities.${clinic.doctor!.specialty}'.tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    verticalSpace(5),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.mainColor,
                      size: 20,
                    ),
                    horizontalSpace(2),
                    Text(
                        '${Format.formatNumber(clinic.rate, context).substring(0, 3)} (${Format.formatNumber(clinic.rateCount, context)})',
                        style: Theme.of(context).textTheme.bodySmall!),
                  ],
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Icon(
                  IconBroken.Location,
                  color: AppColors.mainColor,
                  size: 18,
                ),
                horizontalSpace(5),
                Text(
                  '${clinic.government}, ${clinic.city},${clinic.street}',
                  style: Theme.of(context).textTheme.labelMedium!,
                )
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.secondaryColor.withAlpha(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColors.mainColor,
                        size: 20,
                      ),
                      horizontalSpace(5),
                      Text(
                          '${Format.formatNumber(200, context)} ${'search.patient'.tr()}',
                          style: Theme.of(context).textTheme.bodySmall!),
                    ],
                  ),
                ),
                horizontalSpace(5),
                clinic.services!.contains('Elevator')
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.secondaryColor.withAlpha(15),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.elevator_rounded,
                              color: AppColors.mainColor,
                              size: 20,
                            ),
                            horizontalSpace(5),
                            Text('search.elevator'.tr(),
                                style: Theme.of(context).textTheme.bodySmall!)
                          ],
                        ),
                      )
                    : SizedBox()
              ],
            ),
            verticalSpace(10),
            // Text(
            //   buildNearestAvailableTimeWidget(clinic.workTimes!.workTimes!, context),

            //     // '${'search.available'.tr()} ${clinic.workTimes!.workTimes![0].day} at ${clinic.workTimes!.workTimes![0].start!.hour} : ${clinic.workTimes!.workTimes![0].start!.minute} - ${clinic.workTimes!.workTimes![0].end!.hour} : ${clinic.workTimes!.workTimes![0].end!.minute}',
            //     style: Theme.of(context).textTheme.labelMedium!.copyWith(
            //           color: AppColors.mainColor,
            //         )),
            buildNearestAvailableTimeWidget(clinic.workTimes!, context),
            verticalSpace(10),
            Row(
              children: [
                // Icon(
                //   Icons.attach_money_rounded,
                //   size: 22,
                // ),
                Text.rich(
                  TextSpan(
                    text: Format.formatPrice(clinic.fee, context),
                    style: Theme.of(context).textTheme.bodyLarge!,
                    children: [
                      TextSpan(
                        text: '  ${'search.appPrice'.tr()}',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: AppColors.lightBlue),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                CustomButton(
                  buttonName: 'appointments.bookNow'.tr(),
                  onPressed: () {
                    context.pushNamed(AppRoutes.doctorProfile, arguments: {
                      'clinic': clinic,
                      'user': user,
                      'doctorId': clinic.doctor!.id
                    });
                  },
                  width: Responsive.appWidth(context) > 600 ? 200 : 100,
                  paddingVirtical: 0,
                  height: 35,
                  paddingHorizental: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String getNearestAvailableDay(
      List<WorkTime> workTimes, BuildContext context) {
    DateTime now = DateTime.now();
    List<String> weekDays = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    // Convert WorkTime list to DateTime objects
    List<DateTime> availableDates = [];

    for (var workTime in workTimes) {
      int targetWeekDay = weekDays.indexOf(workTime.day ?? '');
      if (targetWeekDay == -1 || workTime.start == null) continue;

      int todayWeekDay = now.weekday % 7; // Adjust to 0-6 format
      int daysToAdd = (targetWeekDay - todayWeekDay) % 7;
      if (daysToAdd < 0) daysToAdd += 7;

      DateTime availableDate = now.add(Duration(days: daysToAdd));

      DateTime availableDateTime = DateTime(
        availableDate.year,
        availableDate.month,
        availableDate.day,
        workTime.start!.hour,
        workTime.start!.minute,
      );

      availableDates.add(availableDateTime);
    }

    // Sort by earliest available slot
    availableDates.sort((a, b) => a.compareTo(b));

    if (availableDates.isEmpty) return 'search.noAvailabltimes'.tr();

    DateTime nearestDate = availableDates.first;
    String formattedTime =
        DateFormat('hh:mm a', LanguageChecker.isArabic(context) ? 'ar' : 'en')
            .format(nearestDate);

    if (nearestDate.day == now.day) {
      return "${'search.todayAt'.tr()} $formattedTime";
    } else if (nearestDate.day == now.add(Duration(days: 1)).day) {
      return "${'search.tomorrowAt'.tr()} $formattedTime";
    } else {
      return "${DateFormat('EEEE', LanguageChecker.isArabic(context) ? 'ar' : 'en').format(nearestDate)} ${'search.at'.tr()} $formattedTime";
    }
  }

  Text buildNearestAvailableTimeWidget(
      WorkTimes workTimes, BuildContext context) {
    String nearestTime =
        '${'search.available'.tr()} ${getNearestAvailableDay(workTimes.workTimes ?? [], context)}';

    return Text(
      nearestTime,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: AppColors.mainColor,
          ),
    );
  }

  // String near(WorkTimes worktimes) {
  //   DateTime now = DateTime.now();
  //   List<String> weekDays = [
  //     'Sunday',
  //     'Monday',
  //     'Tuesday',
  //     'Wednesday',
  //     'Thursday',
  //     'Friday',
  //     'Saturday'
  //   ];
  //   String near = '';
  //   for (var workTime in worktimes.workTimes!) {
  //     for (var day in weekDays) {
  //       if (workTime.day == day) {
  //         near = day;
  //       }
  //     }
  //   }
  //   return near;
  // }
}
