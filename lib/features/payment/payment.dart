import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appointments.payment'.tr(),
            style: Theme.of(context).textTheme.titleSmall),
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
            onPressed: () {},
            buttonName: 'appointments.confirmPayment'.tr(),
            width: 120,
            paddingVirtical: 5,
            height: 50,
            borderRadius: 20,
            paddingHorizental: 10,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPreferances.padding),
          child: Column(
            children: [
              Text('appointments.paymentMethod'.tr(),
                  style: Theme.of(context).textTheme.labelLarge),
              verticalSpace(20),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainColor.withAlpha(10),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Row(
                  children: [
                    Radio(
                        value: true,
                        groupValue: _value == 1 ? true : false,
                        activeColor: AppColors.mainColor,
                        fillColor: WidgetStatePropertyAll(AppColors.mainColor),
                        onChanged: (value) {
                          setState(() {
                            _value = 1;
                          });
                        }),
                    SvgPicture.asset('assets/images/paypal.svg',
                        height: 30, width: 30),
                    horizontalSpace(10),
                    Text('Paypal',
                        style: Theme.of(context).textTheme.labelLarge)
                  ],
                ),
              ),
              verticalSpace(20),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainColor.withAlpha(10),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Row(
                  children: [
                    Radio(
                        value: true,
                        groupValue: _value == 2 ? true : false,
                        activeColor: AppColors.mainColor,
                        fillColor: WidgetStatePropertyAll(AppColors.mainColor),
                        onChanged: (value) {
                          setState(() {
                            _value = 2;
                          });
                        }),
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/visa.svg',
                            height: 30, width: 30),
                        SvgPicture.asset('assets/images/master-card.svg',
                            height: 30, width: 30),
                      ],
                    ),
                    horizontalSpace(10),
                    Text('appointments.visaOrMasterCard',
                        style: Theme.of(context).textTheme.labelLarge)
                  ],
                ),
              ),
              verticalSpace(20),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainColor.withAlpha(10),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Row(
                  children: [
                    Radio(
                        value: true,
                        groupValue: _value == 3 ? true : false,
                        activeColor: AppColors.mainColor,
                        fillColor: WidgetStatePropertyAll(AppColors.mainColor),
                        onChanged: (value) {
                          setState(() {
                            _value = 3;
                          });
                        }),
                    horizontalSpace(10),
                    Text('appointments.payCash'.tr(),
                        style: Theme.of(context).textTheme.labelLarge)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
