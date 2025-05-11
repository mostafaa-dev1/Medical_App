import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/book_appointment/review_summary/logic/review_summary_cubit.dart';

class SummaryDiscount extends StatelessWidget {
  const SummaryDiscount({super.key, required this.appointment});
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ReviewSummaryCubit>();
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
        child: Form(
          key: cubit.formKey,
          child: Row(
            children: [
              Expanded(
                child: CustomTextFrom(
                    hintText: 'summary.promoCode'.tr(),
                    controller: cubit.discountController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'summary.promoCodeRequired'.tr();
                      }
                      return null;
                    }),
              ),
              horizontalSpace(10),
              CustomButton(
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.discount(
                        providerId: appointment.doctor!.id!,
                        fee: appointment.clinic!.fee!);
                  }
                },
                buttonName: 'summary.apply'.tr(),
                paddingHorizental: 10,
                paddingVirtical: 10,
                width: 100,
              ),
            ],
          ),
        ));
  }
}
