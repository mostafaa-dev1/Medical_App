import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/features/book_appointment/review_summary/logic/review_summary_cubit.dart';
import 'package:medical_system/features/book_appointment/review_summary/review_summary.dart';

class SummaryPaymentDetails extends StatelessWidget {
  const SummaryPaymentDetails({super.key, required this.fee});
  final int fee;

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
            'summary.paymentDetails'.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          verticalSpace(10),
          ReviewSummaryItem(
            title: 'summary.price'.tr(),
            value: Format.formatPrice(fee, context),
          ),
          verticalSpace(5),
          ReviewSummaryItem(
            title: 'summary.discount'.tr(),
            value: Format.formatPrice(cubit.discountAmount, context),
          ),
          verticalSpace(5),
          ReviewSummaryItem(
            title: 'summary.total'.tr(),
            value: Format.formatPrice(cubit.total ?? fee, context),
          )
        ],
      ),
    );
  }
}
