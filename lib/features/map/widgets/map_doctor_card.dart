import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/address_builder.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';

class MapDoctorCard extends StatelessWidget {
  const MapDoctorCard({super.key, required this.appointment});
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
                height: 50,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                    border: Border.all(
                      color: AppColors.mainColor,
                    )),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: appointment.clinic!.doctor!.image != null &&
                              appointment.clinic!.doctor!.image!.isNotEmpty
                          ? NetworkImage(appointment.clinic!.doctor!.image!)
                          : const AssetImage(
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
                    '${LanguageChecker.isArabic(context) ? appointment.clinic!.doctor!.firstNameAr : appointment.clinic!.doctor!.firstName!} ${LanguageChecker.isArabic(context) ? appointment.clinic!.doctor!.lastNameAr : appointment.clinic!.doctor!.lastName}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    appointment.clinic!.doctor!.specialty!,
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
                          appointment.clinic!.doctor!.rate, context),
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
                      appointment.clinic!.address!,
                      appointment.clinic!.city!,
                      appointment.clinic!.government!,
                      context),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              )
            ],
          ),
        )
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
        //           width:
        //               MediaQuery.of(context).size.width > 500 ? 200 : 150,
        //           paddingVirtical: 10,
        //           paddingHorizental: 10),
        //     ),
        //     horizontalSpace(10),
        //     Expanded(
        //       child: CustomButton(
        //           buttonName: 'Open in Maps'.tr(),
        //           onPressed: () async {
        //             await MapsLauncher.launchCoordinates(
        //                 appointment.clinic!.lattitude!,
        //                 appointment.clinic!.longitude!);
        //           },
        //           width:
        //               MediaQuery.of(context).size.width > 500 ? 200 : 150,
        //           paddingVirtical: 10,
        //           paddingHorizental: 10),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
