import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/address_builder.dart';
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
      required this.appointment,
      this.isUpcoming});
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;
  final String? butttonName1;
  final String? butttonName2;
  final Color? color;
  final Color? color2;
  final bool withButtons;
  final bool? withTrailingIcon;
  final Appointment appointment;
  final bool? isUpcoming;

  @override
  Widget build(BuildContext context) {
    // print(appointment.clinic!.doctor!.image);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: withButtons ? 185 : 120,
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
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.primary,
                border: Border.all(color: AppColors.mainColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                  image: appointment.clinic!.doctor!.image != null
                      ? NetworkImage(appointment.clinic!.doctor!.image!)
                      : AssetImage(
                          'assets/images/user.png',
                        ),
                ),
              ),
            ),
            horizontalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '${LanguageChecker.isArabic(context) ? appointment.clinic!.doctor!.firstNameAr : appointment.clinic!.doctor!.firstName} ${LanguageChecker.isArabic(context) ? appointment.clinic!.doctor!.lastNameAr : appointment.clinic!.doctor!.lastName}',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  'specialities.${appointment.clinic!.doctor!.specialty}'.tr(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            Spacer(),
            isUpcoming ?? false
                ? GestureDetector(
                    onTap: () {
                      //print(appointment.clinic!.toJson());
                      // context.pushNamed(AppRoutes.map, arguments: {
                      //   'appointment': appointment,
                      // });
                      context.pushNamed(AppRoutes.googlemap,
                          arguments: appointment);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.mainColor,
                            size: 15,
                          ),
                          horizontalSpace(5),
                          Text(
                            'appointments.location'.tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox()
          ]),
          verticalSpace(10),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.mainColor,
                size: 15,
              ),
              horizontalSpace(5),
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  addressBuilder(
                      appointment.clinic!.address!,
                      appointment.clinic!.city!,
                      appointment.clinic!.government!,
                      context),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
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
                      color: color2,
                    ),
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
      return 'appointments.Today'.tr();
    } else if (appointDate.difference(nowDate).inDays == 1) {
      return 'appointments.Tomorrow'.tr();
    } else {
      return DateFormat(
              'd MMM', context.locale.languageCode == 'en' ? 'en' : 'ar')
          .format(date);
    }
  }
}
