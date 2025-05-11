import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';

class AppointmentLabCard extends StatelessWidget {
  const AppointmentLabCard({super.key, required this.model});
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
      child: Row(
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
                  image: model.lab!.lab!.image != null
                      ? CachedNetworkImageProvider(model.lab!.lab!.image!,
                          maxHeight: 70, maxWidth: 70)
                      : const AssetImage('assets/images/doctor.png'),
                  fit: BoxFit.fill,
                )),
          ),
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LanguageChecker.isArabic(context)
                    ? model.lab!.lab!.nameAr!
                    : model.lab!.lab!.name!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              verticalSpace(5),
              Text(
                'specialities.${model.lab!.lab!.specialty}'.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              verticalSpace(5),
              // Text(
              //   model.doctor!.address!.isNotEmpty
              //       ? model.doctor!.address![0].city!
              //       : 'No Address',
              //   style: Theme.of(context).textTheme.labelMedium,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
