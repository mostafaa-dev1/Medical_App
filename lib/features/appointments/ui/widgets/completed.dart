import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/features/appointments/logic/appointments_cubit.dart';
import 'package:medical_system/features/appointments/ui/widgets/appointment_item.dart';
import 'package:medical_system/features/appointments/ui/widgets/appointments_item_loading.dart';
import 'package:medical_system/features/appointments/ui/widgets/empty_appointments.dart';

class Completed extends StatelessWidget {
  const Completed({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        var cubit = context.read<AppointmentsCubit>();
        final completedVisits = cubit.completedVisits;

        if (state is GetAppointmentsLoading && cubit.selectedIndex == 1) {
          return AppointmentsItemLoading();
        } else {
          if (completedVisits.appointments == null ||
              completedVisits.appointments!.isEmpty) {
            return EmptyAppointments();
          } else {
            return ListView.builder(
                itemCount: completedVisits.appointments!.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppointmentItem(
                        appointment: completedVisits.appointments![index],
                        onTap1: () {
                          log(user.toJson().toString());
                          log(completedVisits.appointments![index].clinic!
                              .workTimes!.workTimes![0]
                              .toJson()
                              .toString());
                          log(completedVisits.appointments![index].doctor!.id!);
                          context.pushNamed(AppRoutes.pickAppointmentDate,
                              arguments: {
                                'workTimes': completedVisits
                                    .appointments![index].clinic!.workTimes,
                                'user': user,
                                'doctor':
                                    completedVisits.appointments![index].clinic,
                                'reason': '',
                                'reschdule': false,
                                'appointmentId': completedVisits
                                    .appointments![index].id!
                                    .toString(),
                                'doctorId': completedVisits
                                    .appointments![index].doctor!.id!
                              });
                        },
                        onTap2: () {
                          context.pushNamed(AppRoutes.writePreview, arguments: {
                            'doctor':
                                completedVisits.appointments![index].doctor,
                            'clinic':
                                completedVisits.appointments![index].clinic,
                            'user': user
                          });
                        },
                        withButtons: true,
                        butttonName1: 'appointments.bookAgain'.tr(),
                        butttonName2: 'appointments.leaveReview'.tr(),
                      ));
                });
          }
        }
      },
    );
  }
}
