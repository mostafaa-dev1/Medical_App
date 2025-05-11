import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/address_builder.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';

class SummaryClinic extends StatelessWidget {
  const SummaryClinic({super.key, required this.appointment});
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryColor.withAlpha(10),
              blurRadius: 5,
              spreadRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: Row(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).colorScheme.primary,
                border: Border.all(
                  color: AppColors.mainColor,
                )),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: appointment.hospital!.clinic!.image == ''
                    ? Image.asset('assets/images/user.png')
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: appointment.hospital!.clinic!.image)),
          ),
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LanguageChecker.isArabic(context)
                    ? appointment.hospital!.clinic!.nameAr
                    : appointment.hospital!.clinic!.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              verticalSpace(5),
              Text(
                'appointments.clinic'.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              verticalSpace(5),
              SizedBox(
                width: MediaQuery.of(context).size.width - 140,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.mainColor,
                      size: 18,
                    ),
                    horizontalSpace(5),
                    Expanded(
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        addressBuilder(
                            appointment.hospital!.address,
                            appointment.hospital!.city,
                            appointment.hospital!.government,
                            context),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
