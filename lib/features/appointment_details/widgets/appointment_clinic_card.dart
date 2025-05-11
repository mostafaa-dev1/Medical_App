import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';

class AppointmentClinicCard extends StatelessWidget {
  const AppointmentClinicCard({super.key, required this.model});
  final Appointment model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 70,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.primary,
                    border: Border.all(
                      color: AppColors.mainColor,
                    )),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: model.hospital!.clinic!.image != ''
                          ? CachedNetworkImageProvider(
                              model.hospital!.clinic!.image)
                          : const AssetImage('assets/images/user.png'),
                      fit: BoxFit.fill,
                    )),
              ),
              horizontalSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LanguageChecker.isArabic(context)
                        ? model.hospital!.clinic!.nameAr
                        : model.hospital!.clinic!.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  verticalSpace(5),
                  Text(
                    'appointments.clinic'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  verticalSpace(5),
                  // Text(
                  //   model.doctor!.address!.isNotEmpty
                  //       ? model.doctor!.address![0].city!
                  //       : 'No Address',
                  //   style: Theme.of(context).textTheme.labelMedium,
                  // ),
                  verticalSpace(5),
                ],
              ),
            ],
          ),
          verticalSpace(10),
          Divider(),
          verticalSpace(10),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                  border: Border.all(
                    color: AppColors.mainColor,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: model.doctor!.image != null
                      ? CachedNetworkImage(
                          imageUrl: model.doctor!.image!,
                          height: 50,
                          width: 50,
                          fit: BoxFit.fill)
                      : Image.asset('assets/images/doctor.png',
                          height: 50, width: 50),
                ),
              ),
              horizontalSpace(5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LanguageChecker.isArabic(context)
                        ? model.doctor!.firstNameAr!
                        : '${model.doctor!.firstName!}  ${LanguageChecker.isArabic(context) ? model.doctor!.lastNameAr! : model.doctor!.lastName!}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  verticalSpace(5),
                  Text(
                    'specialities.${model.doctor!.specialty}'.tr(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
