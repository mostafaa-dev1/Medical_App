import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/features/doctor_profile/widgets/experince_item.dart';

class Experinces extends StatelessWidget {
  const Experinces({super.key, required this.doctor});
  final Clinic doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ExperinceItem(
            title: 'doctorProfile.patients'.tr(),
            amount: '+${Format.formatNumber(5000, context)}',
            icon: IconBroken.User1),
        ExperinceItem(
            title: 'doctorProfile.experince'.tr(),
            amount: Format.formatNumber(10, context),
            icon: Icons.medical_information_outlined),
        ExperinceItem(
            title: 'doctorProfile.rating'.tr(),
            amount: Format.formatNumberToDouble(doctor.rate, context)
                .substring(0, 3),
            icon: IconBroken.Star),
        ExperinceItem(
            title: 'doctorProfile.reviews'.tr(),
            amount: Format.formatNumber(doctor.rateCount, context),
            icon: IconBroken.Chat),
      ],
    );
  }
}
