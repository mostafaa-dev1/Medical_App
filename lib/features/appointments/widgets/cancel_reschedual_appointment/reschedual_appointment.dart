import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class ReschedualAppointment extends StatefulWidget {
  const ReschedualAppointment({super.key});

  @override
  State<ReschedualAppointment> createState() => _ReschedualAppointmentState();
}

class _ReschedualAppointmentState extends State<ReschedualAppointment> {
  final List<String> secheduleReasons = [
    'appointments.sechduleCash',
    'appointments.timeProblem',
    'appointments.activityProblem',
    'appointments.other',
  ];
  int selectedReason = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'appointments.rescheduleAppointment'.tr(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPreferances.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'appointments.rescheduleReason'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              verticalSpace(20),
              ...List.generate(
                secheduleReasons.length,
                (index) => Row(
                  children: [
                    Radio(
                      value: index,
                      fillColor: WidgetStateProperty.all(AppColors.mainColor),
                      groupValue: selectedReason,
                      activeColor: AppColors.mainColor,
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value!;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedReason = index;
                        });
                      },
                      child: Text(secheduleReasons[index].tr(),
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
              verticalSpace(20),
              secheduleReasons[selectedReason] == 'appointments.other'
                  ? CustomTextFrom(
                      withhint: true,
                      hintText: 'appointments.reason'.tr(),
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                    )
                  : SizedBox(),
              Spacer(),
              CustomButton(
                  buttonName: 'appointments.next'.tr(),
                  onPressed: () {
                    context.pushNamed(AppRoutes.pickAppointmentDate);
                  },
                  width: double.infinity,
                  height: 50,
                  paddingVirtical: 10,
                  paddingHorizental: 10)
            ],
          ),
        ));
  }
}
