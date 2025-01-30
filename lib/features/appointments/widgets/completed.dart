import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/features/appointments/widgets/doctor_card.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DoctorCard(
                withButtons: true,
                butttonName1: 'appointments.bookAgain'.tr(),
                butttonName2: 'appointments.leaveReview'.tr(),
              ));
        });
  }
}
