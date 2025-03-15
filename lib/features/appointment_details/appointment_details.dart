import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/appointments/widgets/cancel_reschedual_appointment/cancel_appointment.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class AppointmentDetails extends StatelessWidget {
  AppointmentDetails({super.key});
  final pageIndexNotifier = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('summary.appointmentDetails'.tr(),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomButton(
                    buttonName: 'appointments.cancel'.tr(),
                    onPressed: () {
                      WoltModalSheet.show<void>(
                        pageIndexNotifier: pageIndexNotifier,
                        context: context,
                        pageListBuilder: (modalSheetContext) {
                          return [
                            page1(modalSheetContext, pageIndexNotifier),
                            page2(modalSheetContext, pageIndexNotifier),
                          ];
                        },
                        onModalDismissedWithBarrierTap: () {
                          debugPrint('Closed modal sheet with barrier tap');
                          pageIndexNotifier.value = 0;
                        },
                      );
                    },
                    backgroundColor: AppColors.lightRed.withAlpha(20),
                    buttonColor: AppColors.lightRed,
                    width: 130,
                    paddingVirtical: 10,
                    paddingHorizental: 10),
              ),
              horizontalSpace(20),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    context.pushNamed(AppRoutes.rescheduleAppointment);
                  },
                  buttonName: 'appointments.reschedule'.tr(),
                  width: 130,
                  paddingVirtical: 5,
                  paddingHorizental: 10,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(AppPreferances.padding),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
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
                    Text(
                      'Egypt/Cairo',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
            verticalSpace(20),
            Text(
              'summary.appointmentDetails'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            verticalSpace(10),
            AppointmentDetailsItem(title: 'summary.appId', value: '123456789'),
            verticalSpace(10),
            AppointmentDetailsItem(title: 'summary.date', value: '2023-05-01'),
            verticalSpace(10),
            AppointmentDetailsItem(title: 'summary.time', value: '10:00 AM'),
            verticalSpace(10),
            AppointmentDetailsItem(title: 'summary.status', value: 'Pending'),
            verticalSpace(10),
            AppointmentDetailsItem(title: 'summary.appPrice', value: '200 EGP'),
            verticalSpace(20),
            Row(
              children: [
                Text(
                  'summary.patientDetails'.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Spacer(),
                Icon(
                  IconBroken.Edit,
                  color: AppColors.secondaryColor,
                  size: 20,
                ),
              ],
            ),
            verticalSpace(10),
            AppointmentDetailsItem(title: 'summary.name', value: 'John Doe'),
            verticalSpace(10),
            AppointmentDetailsItem(title: 'summary.age', value: '25'),
            verticalSpace(10),
            AppointmentDetailsItem(
              title: 'summary.gender',
              value: 'Male',
            ),
            verticalSpace(10),
            AppointmentDetailsItem(
              title: 'summary.phoneNumber',
              value: '0123456789',
            ),
            verticalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'summary.problem'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                verticalSpace(10),
                Text(
                  'I have a problem with my heart',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ])),
    );
  }
}

class AppointmentDetailsItem extends StatelessWidget {
  const AppointmentDetailsItem({
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
          title.tr(),
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
