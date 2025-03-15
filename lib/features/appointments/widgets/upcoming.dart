import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/features/appointments/widgets/cancel_reschedual_appointment/cancel_appointment.dart';
import 'package:medical_system/features/appointments/widgets/doctor_card.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class Upcoming extends StatelessWidget {
  Upcoming({super.key});
  final List<String> reasons = [
    'I want to change to another doctor',
    'I have recovered from my illness',
    'I have found suitable medicine',
    'I have a medical emergency',
    'I have a personal reason',
    'I just want to cancel'
  ];
  final String selectedReason = '';

  final pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.map);
                },
                child: DoctorCard(
                  butttonName1: 'appointments.cancel'.tr(),
                  butttonName2: 'appointments.reschedule'.tr(),
                  onTap1: () {
                    WoltModalSheet.show<void>(
                      pageIndexNotifier: pageIndexNotifier,
                      context: context,
                      pageListBuilder: (modalSheetContext) {
                        return [
                          page1(modalSheetContext, pageIndexNotifier),
                          page2(modalSheetContext, pageIndexNotifier),
                        ];
                      },
                      onModalDismissedWithBarrierTap: () {
                        debugPrint('Closed modal sheet with barrier tap');
                        pageIndexNotifier.value = 0;
                      },
                    );
                  },
                  onTap2: () {
                    context.pushNamed(AppRoutes.rescheduleAppointment);
                  },
                  color: Colors.red,
                  withButtons: true,
                ),
              ));
        });
  }
}
