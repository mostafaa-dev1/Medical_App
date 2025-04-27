import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/themes/colors.dart';

class DoctorInfoProfile extends StatelessWidget {
  const DoctorInfoProfile({super.key, required this.doctor});
  final Clinic doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(
                color: AppColors.mainColor,
              )),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: doctor.doctor!.image != null &&
                      doctor.doctor!.image!.isNotEmpty
                  ? CachedNetworkImage(
                      fit: BoxFit.cover, imageUrl: doctor.doctor!.image!)
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
              '${'appointments.dr'.tr()} ${LanguageChecker.isArabic(context) ? doctor.doctor!.firstNameAr : doctor.doctor!.firstName} ${LanguageChecker.isArabic(context) ? doctor.doctor!.lastNameAr : doctor.doctor!.lastName}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalSpace(5),
            Text(
              'specialities.${doctor.doctor!.specialty}'.tr(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            verticalSpace(5),
            Text(
              '${doctor.government}, ${doctor.city}, ${doctor.street}',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ],
    );
  }
}
