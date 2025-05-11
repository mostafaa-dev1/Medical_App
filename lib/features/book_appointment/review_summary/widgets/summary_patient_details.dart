import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/book_appointment/review_summary/review_summary.dart';

class SummaryPatientDetails extends StatelessWidget {
  const SummaryPatientDetails({super.key, required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {
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
          children: [
            verticalSpace(10),
            Text(
              'summary.patientDetails'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalSpace(10),
            ReviewSummaryItem(
              title: 'summary.name'.tr(),
              value: patient.name!,
            ),
            verticalSpace(5),
            ReviewSummaryItem(
              title: 'summary.age'.tr(),
              value: Format.formatNumber(patient.age, context),
            ),
            verticalSpace(5),
            ReviewSummaryItem(
              title: 'summary.gender'.tr(),
              value: 'summary.${patient.gender!.toLowerCase()}'.tr(),
            ),
            verticalSpace(5),
            ReviewSummaryItem(
              title: 'summary.phoneNumber'.tr(),
              value: '+20${patient.phone!}',
            ),
            verticalSpace(5),
            Align(
              alignment: LanguageChecker.isArabic(context)
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'summary.problem'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  verticalSpace(5),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      patient.problem ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
