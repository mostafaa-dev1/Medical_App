import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/main/logic/main_cubit.dart';

class UpcomingItem extends StatelessWidget {
  const UpcomingItem({super.key, required this.index, required this.model});
  final int index;
  final Appointment model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.appointmentDetails, arguments: {
          'id': model.id,
          'user': context.read<MainCubit>().user
        });
      },
      child: Container(
        margin: EdgeInsets.only(
          left: LanguageChecker.isArabic(context) ? 0 : 10,
          right: LanguageChecker.isArabic(context) ? 10 : 0,
          top: 10,
          bottom: 10,
        ),
        width: 270,
        height: 120,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).colorScheme.primary),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 20, backgroundImage: getImage()),
                horizontalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getTitle(context),
                      style: Theme.of(context).textTheme.bodyMedium!,
                    ),
                    Text(getSubtitle(context),
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_vert, size: 20),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Icon(
                  IconBroken.Time_Circle,
                  size: 15,
                ),
                horizontalSpace(5),
                Text(
                  '${calculateDateDifference(model.date!, context)} | ${Format.formatSringTime(model.time!, context)}',
                  style: Theme.of(context).textTheme.labelMedium!,
                ),
                Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: model.status == 'Pending'
                              ? AppColors.secondaryColor
                              : model.status == 'Canceled'
                                  ? AppColors.lightRed
                                  : AppColors.lightGreen,
                          width: 1)),
                  child: Text(
                    'appointments.${model.status}'.tr(),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: model.status == 'Pending'
                            ? AppColors.secondaryColor
                            : model.status == 'Canceled'
                                ? AppColors.lightRed
                                : AppColors.lightGreen,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )
          ],
        ),
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

  String getTitle(BuildContext context) {
    if (model.clinic != null) {
      final doctor = model.clinic!.doctor!;
      return '${'appointments.dr'.tr()} ${LanguageChecker.isArabic(context) ? doctor.firstNameAr : doctor.firstName} ${LanguageChecker.isArabic(context) ? doctor.lastNameAr : doctor.lastName}';
    } else if (model.lab != null) {
      return LanguageChecker.isArabic(context)
          ? model.lab!.lab!.nameAr!
          : model.lab!.lab!.name!;
    } else if (model.hospital != null) {
      return LanguageChecker.isArabic(context)
          ? model.hospital!.clinic!.nameAr
          : model.hospital!.clinic!.name;
    } else {
      return 'Unknown';
    }
  }

  String getSubtitle(BuildContext context) {
    if (model.clinic != null && model.clinic!.doctor != null) {
      return 'specialities.${model.clinic!.doctor!.specialty}'.tr();
    } else if (model.lab != null) {
      return 'specialities.${model.lab!.lab!.specialty}'
          .tr(); // Add translation key
    } else if (model.hospital != null) {
      return 'appointments.clinic'.tr(); // Add translation key
    } else {
      return '';
    }
  }

  ImageProvider getImage() {
    if (model.clinic != null) {
      return NetworkImage(model.clinic!.doctor!.image!);
    } else if (model.lab != null) {
      return CachedNetworkImageProvider(model.lab!.lab!.image!);
    } else if (model.hospital != null) {
      return CachedNetworkImageProvider(model.hospital!.clinic!.image);
    } else {
      return const AssetImage('assets/images/user.png');
    }
  }
}
