import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/features/appointments/logic/appointments_cubit.dart';
import 'package:medical_system/features/appointments/ui/widgets/appointment_item.dart';
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
          return EmptyAppointments();
        } else {
          return ListView.builder(
              itemCount: canceledVisits.appointments!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppointmentItem(
                      appointment: canceledVisits.appointments![index],
                      withButtons: false,
                      withTrailingIcon: false,
                    ));
              });
        }
      }
    });
  }
}
