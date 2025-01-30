import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/features/appointments/widgets/doctor_card.dart';

class Upcoming extends StatelessWidget {
  const Upcoming({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: DoctorCard(
                butttonName1: 'appointments.cancel'.tr(),
                butttonName2: 'appointments.reschedule'.tr(),
                color: Colors.red,
                withButtons: true,
              ));
        });
  }
}
