import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/book_appointment/review_summary/logic/review_summary_cubit.dart';

class SelectPaymentMethod extends StatelessWidget {
  const SelectPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReviewSummaryCubit>();
    final selectedPaymentIndex = cubit.paymentIndex;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      padding: EdgeInsets.all(10),
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
          Row(
            children: [
              Radio(
                visualDensity: VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                value: 1,
                groupValue: selectedPaymentIndex,
                activeColor: AppColors.mainColor,
                onChanged: (value) {
                  cubit.changePaymentIndex(value!);
                },
              ),
              horizontalSpace(10),
              Text(
                'summary.payWithcard'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Spacer(),
              Image.asset(
                'assets/images/visa3.png',
                height: 30,
                width: 30,
              ),
              horizontalSpace(5),
              Image.asset(
                'assets/images/master.png',
                height: 20,
                width: 30,
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                visualDensity: VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                value: 2,
                groupValue: selectedPaymentIndex,
                activeColor: AppColors.mainColor,
                onChanged: (value) {
                  cubit.changePaymentIndex(value!);
                },
              ),
              horizontalSpace(10),
              Text(
                'summary.payCash'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
