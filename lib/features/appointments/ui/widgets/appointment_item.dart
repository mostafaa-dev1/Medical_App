import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/doctor_card_button.dart';
import 'package:medical_system/core/widgets/doctor_card_oulined_button.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';

class AppointmentItem extends StatelessWidget {
  const AppointmentItem(
      {super.key,
      this.onTap1,
      this.onTap2,
      this.butttonName1,
      this.butttonName2,
      this.color,
      this.color2,
      this.withTrailingIcon,
      required this.withButtons,
      required this.appointment});
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;
  final String? butttonName1;
  final String? butttonName2;
  final Color? color;
  final Color? color2;
  final bool withButtons;
  final bool? withTrailingIcon;
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: withButtons ? 155 : 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                height: 50,
                width: 50,
                fit: BoxFit.fill,
                image: appointment.doctor!.image != null
                    ? NetworkImage(appointment.doctor!.image!)
                    : AssetImage(
                        'assets/images/doctor.png',
                      ),
              ),
            ),
            horizontalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '${LanguageChecker.isArabic(context) ? appointment.doctor!.firstNameAr : appointment.doctor!.firstName} ${LanguageChecker.isArabic(context) ? appointment.doctor!.lastNameAr : appointment.doctor!.lastName}',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text('specialities.${appointment.doctor!.specialty}'.tr(),
                    style: Theme.of(context).textTheme.labelMedium),
                Row(
                  children: [
                    Icon(
                      IconBroken.Location,
                      size: 15,
                    ),
                    horizontalSpace(5),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      ' ${appointment.clinic!.government!} | ${appointment.clinic!.city!} | ${appointment.clinic!.street!}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                print(appointment.clinic!.toJson());
                context.pushNamed(AppRoutes.map, arguments: {
                  'clinic': appointment.clinic,
                  'doctor': appointment.doctor,
                });
              },
              child: Icon(
                IconBroken.Location,
                size: 25,
              ),
            )
          ]),
          verticalSpace(10),
          Row(
            children: [
              Icon(
                IconBroken.Time_Circle,
                size: 15,
              ),
              horizontalSpace(5),
              Text(
                  '${calculateDateDifference(appointment.date!, context)} | ${DateFormat('hh:mm a', context.locale.languageCode == 'en' ? 'en' : 'ar').format(appointment.date!)}',
                  style: Theme.of(context).textTheme.labelMedium),
              Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: appointment.status == 'Pending'
                          ? AppColors.mainColor
                          : appointment.status == 'Cancelled'
                              ? AppColors.lightRed
                              : AppColors.lightGreen),
                ),
                child: Text(
                  'appointments.${appointment.status}'.tr(),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: appointment.status == 'Pending'
                            ? AppColors.mainColor
                            : appointment.status == 'Cancelled'
                                ? AppColors.lightRed
                                : AppColors.lightGreen,
                      ),
                ),
              )
            ],
          ),
          withButtons ? verticalSpace(20) : SizedBox(),
          withButtons
              ? Row(
                  textDirection: ui.TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DoctorCardOulinedButton(
                      onTap: onTap1,
                      withIcon: false,
                      buttonName: butttonName1 ?? '',
                      borderColor: color,
                    ),
                    horizontalSpace(10),
                    DoctorCardButton(
                        onTap: onTap2,
                        buttonName: butttonName2 ?? '',
                        color: color2),
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }

  String calculateDateDifference(DateTime date, BuildContext context) {
    final now = DateTime.now();
    DateTime appointDate = DateTime(date.year, date.month, date.day);
    DateTime nowDate = DateTime(now.year, now.month, now.day);
    if (appointDate == nowDate) {
      return 'Today';
    } else if (appointDate.difference(nowDate).inDays == 1) {
      return 'Tomorrow';
    } else {
      return DateFormat(
              'd MMM', context.locale.languageCode == 'en' ? 'en' : 'ar')
          .format(date);
    }
  }
}
