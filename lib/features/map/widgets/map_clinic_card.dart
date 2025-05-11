import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/address_builder.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';

class MapClinicCard extends StatelessWidget {
  const MapClinicCard({super.key, required this.appointment});
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 70,
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.primary,
                    border: Border.all(
                      color: AppColors.mainColor,
                    )),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: appointment.hospital!.clinic!.image.isNotEmpty
                        ? CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: appointment.hospital!.clinic!.image)
                        : Image(
                            image: AssetImage(
                              'assets/images/doctor.png',
                            ),
                            fit: BoxFit.fill,
                          )),
              ),
              horizontalSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LanguageChecker.isArabic(context)
                        ? appointment.hospital!.clinic!.nameAr
                        : appointment.hospital!.clinic!.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'appointments.clinic'.tr(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.mainColor.withAlpha(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.mainColor,
                    ),
                    horizontalSpace(5),
                    Text(
                      Format.formatNumberToDouble(
                          appointment.hospital!.rate!, context),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        verticalSpace(10),
        SizedBox(
          width: MediaQuery.of(context).size.width - 70,
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.mainColor,
                size: 15,
              ),
              horizontalSpace(5),
              Expanded(
                child: Text(
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
        // Row(
        //   children: [
        //     Expanded(
        //       child: CustomButton(
        //           buttonName: 'Back'.tr(),
        //           onPressed: () {
        //             context.pop();
        //           },
        //           backgroundColor: AppColors.mainColor.withAlpha(10),
        //           buttonColor: AppColors.mainColor,
        //           width: MediaQuery.of(context).size.width > 500 ? 200 : 150,
        //           paddingVirtical: 10,
        //           paddingHorizental: 10),
        //     ),
        //     horizontalSpace(10),
        //     Expanded(
        //       child: CustomButton(
        //           buttonName: 'Open in Maps'.tr(),
        //           onPressed: () async {
        //             await MapsLauncher.launchCoordinates(
        //                 double.parse(
        //                     appointment.hospital!.location['latitude']!),
        //                 double.parse(
        //                     appointment.hospital!.location['longtude']!));
        //           },
        //           width: MediaQuery.of(context).size.width > 500 ? 200 : 150,
        //           paddingVirtical: 10,
        //           paddingHorizental: 10),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
