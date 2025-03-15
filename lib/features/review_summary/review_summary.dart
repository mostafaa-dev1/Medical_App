import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class ReviewSummary extends StatelessWidget {
  const ReviewSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'summary.reviewSummary'.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        padding: EdgeInsets.zero,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: CustomButton(
            onPressed: () {
              context.pushNamed(AppRoutes.reviewSummary);
            },
            buttonName: 'summary.confirm'.tr(),
            width: 120,
            paddingVirtical: 5,
            height: 50,
            borderRadius: 20,
            paddingHorizental: 10,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryColor.withAlpha(10),
                      blurRadius: 5,
                      spreadRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(
                          color: AppColors.mainColor,
                        )),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: AssetImage('assets/images/doctor.png'),
                          fit: BoxFit.fill,
                        )),
                  ),
                  horizontalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. John Doe',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      verticalSpace(5),
                      Text(
                        'Brain and Nerves doctor',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      verticalSpace(5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.mainColor,
                            size: 18,
                          ),
                          horizontalSpace(5),
                          Text(
                            'Egypt/Cairo',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
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
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  verticalSpace(10),
                  ReviewSummaryItem(
                      title: 'summary.date'.tr(), value: '10/10/2023'),
                  verticalSpace(5),
                  ReviewSummaryItem(
                      title: 'summary.time'.tr(),
                      value: '10:00 ${'summary.am'.tr()}'),
                  verticalSpace(5),
                  ReviewSummaryItem(
                      title: 'summary.paymentMethod'.tr(),
                      value: 'summary.cash'.tr()),
                ],
              ),
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow,
                        blurRadius: 5,
                        spreadRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFrom(
                        hintText: 'summary.promoCode'.tr(),
                        controller: TextEditingController(),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    horizontalSpace(10),
                    CustomButton(
                      onPressed: () {},
                      buttonName: 'summary.apply'.tr(),
                      paddingHorizental: 10,
                      paddingVirtical: 10,
                      width: 100,
                    ),
                  ],
                )),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
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
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  verticalSpace(10),
                  ReviewSummaryItem(
                    title: 'summary.price'.tr(),
                    value: '1000${'summary.EGP'.tr()}',
                  ),
                  verticalSpace(5),
                  ReviewSummaryItem(
                    title: 'summary.discount'.tr(),
                    value: '100${'summary.EGP'.tr()}',
                  ),
                  verticalSpace(5),
                  ReviewSummaryItem(
                    title: 'Total',
                    value: '1500${'summary.EGP'.tr()}',
                  )
                ],
              ),
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
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
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    verticalSpace(10),
                    ReviewSummaryItem(
                      title: 'summary.name'.tr(),
                      value: 'Ahmed',
                    ),
                    verticalSpace(5),
                    ReviewSummaryItem(
                      title: 'summary.age'.tr(),
                      value: '25',
                    ),
                    verticalSpace(5),
                    ReviewSummaryItem(
                      title: 'summary.gender'.tr(),
                      value: 'Male',
                    ),
                    verticalSpace(5),
                    ReviewSummaryItem(
                      title: 'summary.phoneNumber'.tr(),
                      value: '0123456789',
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
                              'I feel pain in my back',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class ReviewSummaryItem extends StatelessWidget {
  const ReviewSummaryItem({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
