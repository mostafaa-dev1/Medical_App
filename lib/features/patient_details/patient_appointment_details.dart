import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/custom_dropdown.dart';

class PatientAppointmentDetails extends StatelessWidget {
  const PatientAppointmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appointments.patientDetails".tr(),
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
            onPressed: () {
              context.pushNamed(AppRoutes.reviewSummary);
            },
            buttonName: 'appointments.next'.tr(),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFrom(
                withhint: true,
                hintText: 'appointments.name'.tr(),
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
              ),
              verticalSpace(20),
              CustomTextFrom(
                withhint: true,
                hintText: 'appointments.age'.tr(),
                controller: TextEditingController(),
                keyboardType: TextInputType.number,
              ),
              verticalSpace(20),
              AppCustomDropDown(
                  list: const ['appoitments.male', 'appoitments.female'],
                  width: double.infinity,
                  height: 50,
                  text: 'appointments.gender'.tr(),
                  hintText: 'appointments.gender'.tr()),
              verticalSpace(20),
              CustomTextFrom(
                withhint: true,
                hintText: 'appointments.phoneNumber'.tr(),
                controller: TextEditingController(),
                keyboardType: TextInputType.phone,
              ),
              verticalSpace(20),
              CustomTextFrom(
                maxLines: null,
                withhint: true,
                hintText: 'appointments.wahtIsYourProblem'.tr(),
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
