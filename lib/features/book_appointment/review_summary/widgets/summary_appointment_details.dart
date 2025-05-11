import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/book_appointment/review_summary/logic/review_summary_cubit.dart';
import 'package:medical_system/features/book_appointment/review_summary/review_summary.dart';

class SummaryAppointmentDetails extends StatelessWidget {
  const SummaryAppointmentDetails({super.key, required this.appointment});
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReviewSummaryCubit>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 5,
              spreadRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'summary.appointmentDetails'.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          verticalSpace(10),
          ReviewSummaryItem(
              title: 'summary.date'.tr(),
              value: Format.formatDate(appointment.date!, context)),
          verticalSpace(5),
          ReviewSummaryItem(
              title: 'summary.time'.tr(),
              value: Format.formatSringTime(appointment.time!, context)),
          verticalSpace(5),
          ReviewSummaryItem(
            title: 'summary.paymentMethod'.tr(),
            value: cubit.paymentIndex == 1
                ? 'summary.card'.tr()
                : cubit.paymentIndex == 2
                    ? 'summary.cash'.tr()
                    : '',
          ),
        ],
      ),
    );
  }
}
