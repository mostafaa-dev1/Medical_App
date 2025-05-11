import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';

class ReschedualAppointment extends StatefulWidget {
  const ReschedualAppointment(
      {super.key,
      required this.appointmentId,
      required this.workTimes,
      required this.appointment,
      //required this.clinic,
      required this.doctorId});
  final String appointmentId;
  final WorkTimes workTimes;
  // final Clinic clinic;
  final String doctorId;
  final Appointment appointment;

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
    print(widget.appointmentId);
    return Scaffold(
        persistentFooterButtons: [
          CustomButton(
              buttonName: 'appointments.next'.tr(),
              onPressed: () {
                print(widget.doctorId);
                context.pushNamed(AppRoutes.pickAppointmentDate, arguments: {
                  'workTimes': widget.workTimes,
                  'user': UserModel(),
                  // 'doctor': widget.clinic,
                  'appointment': widget.appointment,
                  'reason': secheduleReasons[selectedReason].tr(),
                  'reschdule': true,
                  'appointmentId': widget.appointmentId,
                  'doctorId': widget.doctorId
                });
              },
              width: double.infinity,
              height: 40,
              paddingVirtical: 10,
              paddingHorizental: 10)
        ],
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
                style: Theme.of(context).textTheme.bodyMedium,
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall),
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
            ],
          ),
        ));
  }
}
