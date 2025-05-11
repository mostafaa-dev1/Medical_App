import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/features/appointments/logic/appointments_cubit.dart';
import 'package:medical_system/features/appointments/ui/widgets/appointment_clinic_item.dart';
import 'package:medical_system/features/appointments/ui/widgets/appointment_item.dart';
import 'package:medical_system/features/appointments/ui/widgets/appointment_lab_item.dart';
import 'package:medical_system/features/appointments/ui/widgets/appointments_item_loading.dart';
import 'package:medical_system/features/appointments/ui/widgets/empty_appointments.dart';

class Canceled extends StatelessWidget {
  const Canceled({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
        builder: (context, state) {
      var cubit = context.read<AppointmentsCubit>();
      final canceledVisits = cubit.canceledVisits;
      if (state is GetAppointmentsLoading) {
        return AppointmentsItemLoading();
      } else {
        if (canceledVisits.appointments == null ||
            canceledVisits.appointments!.isEmpty) {
          return EmptyAppointments(
            title: 'appointments.youDontHaveCanceledAppointments'.tr(),
          );
        } else {
          return ListView.builder(
              itemCount: canceledVisits.appointments!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: canceledVisits.appointments![index].clinic != null
                        ? AppointmentItem(
                            appointment: canceledVisits.appointments![index],
                            withButtons: false,
                            withTrailingIcon: false,
                          )
                        : canceledVisits.appointments![index].hospital != null
                            ? AppointmentClinicItem(
                                appointment:
                                    canceledVisits.appointments![index],
                                withButtons: false,
                                withTrailingIcon: false,
                              )
                            : canceledVisits.appointments![index].lab != null
                                ? AppointmentLabItem(
                                    appointment:
                                        canceledVisits.appointments![index],
                                    withButtons: false,
                                    withTrailingIcon: false,
                                  )
                                : const SizedBox());
              });
        }
      }
    });
  }
}
