import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/appointments/logic/appointments_cubit.dart';
import 'package:medical_system/features/appointments/ui/widgets/appointment_item.dart';
import 'package:medical_system/features/appointments/ui/widgets/appointments_item_loading.dart';
import 'package:medical_system/features/appointments/ui/widgets/empty_appointments.dart';

class Upcoming extends StatelessWidget {
  Upcoming({
    super.key,
  });

  final List<String> reasons = [
    'appointments.anotherDoctor'.tr(),
    'appointments.recoveredIllness'.tr(),
    'appointments.suitableMedicine'.tr(),
    'appointments.moneyIssue'.tr(),
    'appointments.personalReason'.tr(),
    'appointments.justCancel'.tr()
  ];
  final String selectedReason = '';

  final pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
        builder: (context, state) {
      var cubit = context.read<AppointmentsCubit>();
      final upcomingVisits = cubit.upcomingVisits;
      if (state is GetAppointmentsLoading && cubit.selectedIndex == 0) {
        return AppointmentsItemLoading();
      } else {
        if (upcomingVisits.appointments == null ||
            upcomingVisits.appointments!.isEmpty) {
          return EmptyAppointments();
        } else {
          return ListView.builder(
              itemCount: upcomingVisits.appointments!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.map, arguments: {
                          'doctor': upcomingVisits.appointments![index].doctor,
                          'clinic': upcomingVisits.appointments![index].clinic
                        });
                      },
                      child: AppointmentItem(
                        appointment: upcomingVisits.appointments![index],
                        butttonName1: 'appointments.cancel'.tr(),
                        butttonName2: 'appointments.reschedule'.tr(),
                        onTap1: () {
                          showModalBottomSheet(
                              constraints: BoxConstraints(maxHeight: 250),
                              context: context,
                              enableDrag: true,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              builder: (_) {
                                return cnacelAppointment(context,
                                    upcomingVisits.appointments![index]);
                              });
                          // WoltModalSheet.show<void>(
                          //   pageIndexNotifier: pageIndexNotifier,
                          //   context: context,
                          //   pageListBuilder: (modalSheetContext) {
                          //     return [
                          //       page1(modalSheetContext, pageIndexNotifier),
                          //       page2(modalSheetContext, pageIndexNotifier),
                          //     ];
                          //   },
                          //   onModalDismissedWithBarrierTap: () {
                          //     pageIndexNotifier.value = 0;
                          //   },
                          // );
                        },
                        onTap2: () {
                          context.pushNamed(AppRoutes.rescheduleAppointment,
                              arguments: {
                                'appointmentId': upcomingVisits
                                    .appointments![index].id
                                    .toString(),
                                'workTimes': upcomingVisits
                                    .appointments![index].clinic!.workTimes,
                                'clinic':
                                    upcomingVisits.appointments![index].clinic,
                                'doctorId': upcomingVisits
                                    .appointments![index].doctor!.id
                              });
                        },
                        color: Colors.red,
                        withButtons: true,
                      ),
                    ));
              });
        }
      }
    });
  }

  Widget cnacelAppointment(BuildContext context, Appointment appointment) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'appointments.cancelAppointment'.tr(),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.red,
                ),
          ),
          verticalSpace(20),
          Text(
            textAlign: TextAlign.center,
            'appointments.cancelAppointmentMessage'.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  backgroundColor: AppColors.mainColor.withAlpha(20),
                  buttonColor: AppColors.mainColor,
                  buttonName: 'appointments.no'.tr(),
                  onPressed: () {
                    context.pop();
                  },
                  width: MediaQuery.of(context).size.width > 500 ? 200 : 150,
                  paddingVirtical: 5,
                  paddingHorizental: 10),
              horizontalSpace(10),
              CustomButton(
                buttonName: 'appointments.yes'.tr(),
                onPressed: () {
                  context.pop();
                  context.pushNamed(AppRoutes.cancelAppointment, arguments: {
                    'appointment': appointment,
                    'context': context,
                  });
                },
                width: MediaQuery.of(context).size.width > 500 ? 200 : 150,
                paddingVirtical: 5,
                paddingHorizental: 10,
              )
            ],
          ),
        ],
      ),
    );
  }
}
