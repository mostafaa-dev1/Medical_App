import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/appointment_details/widgets/appointment_clinic_card.dart';
import 'package:medical_system/features/appointment_details/widgets/appointment_details_loading.dart';
import 'package:medical_system/features/appointment_details/widgets/appointment_doctor_card.dart';
import 'package:medical_system/features/appointment_details/widgets/appointment_lab_card.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/appointments/logic/appointments_cubit.dart';

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({
    super.key,
    required this.user,
  });
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentsCubit, AppointmentsState>(
      listener: (context, state) {
        if (state is GetAppointmentsError) {
          showCustomDialog(
              context: context,
              message: 'dialog.somethingWentWrong'.tr(),
              title: 'dialog.oops'.tr(),
              onConfirmPressed: () {},
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.error);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AppointmentsCubit>();
        var model = cubit.appointment;
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
                          showModalBottomSheet(
                              constraints: BoxConstraints(maxHeight: 250),
                              context: context,
                              enableDrag: true,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              builder: (_) {
                                return cnacelAppointment(context, model!, user);
                              });
                          // WoltModalSheet.show<void>(
                          //   pageIndexNotifier: pageIndexNotifier,
                          //   context: context,
                          //   pageListBuilder: (modalSheetContext) {
                          //     return [
                          //       // page1(modalSheetContext, pageIndexNotifier),
                          //       // page2(modalSheetContext, pageIndexNotifier),
                          //     ];
                          //   },
                          //   onModalDismissedWithBarrierTap: () {
                          //     debugPrint('Closed modal sheet with barrier tap');
                          //     pageIndexNotifier.value = 0;
                          //   },
                          // );
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
                        context.pushNamed(AppRoutes.rescheduleAppointment,
                            arguments: {
                              'appointmentId': model!.id.toString(),
                              'workTimes': model.clinic!.workTimes,
                              'clinic': model.clinic,
                              'doctorId': model.doctor!.id,
                            });
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
          body: state is GetAppointmentsLoading
              ? AppointmentDetailsLoading()
              : Padding(
                  padding: const EdgeInsets.all(AppPreferances.padding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        model!.clinic != null
                            ? AppointmentDoctorCard(model: model)
                            : model.hospital != null
                                ? AppointmentClinicCard(model: model)
                                : AppointmentLabCard(model: model),
                        verticalSpace(10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).colorScheme.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.shadow,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   'summary.appointmentDetails'.tr(),
                              //   style: Theme.of(context).textTheme.bodyLarge,
                              // ),
                              // verticalSpace(10),
                              AppointmentDetailsItem(
                                  title: 'summary.appId',
                                  value:
                                      '#${Format.formatNumber(model.id!, context)}'),
                              verticalSpace(10),
                              AppointmentDetailsItem(
                                  title: 'summary.date',
                                  value:
                                      Format.formatDate(model.date!, context)),
                              verticalSpace(10),
                              AppointmentDetailsItem(
                                  title: 'summary.time',
                                  value: Format.formatSringTime(
                                      model.time!, context)),
                              verticalSpace(10),
                              AppointmentDetailsItem(
                                  title: 'summary.status',
                                  value: 'appointments.${model.status!}'.tr()),
                              verticalSpace(10),
                              AppointmentDetailsItem(
                                  title: 'summary.appPrice',
                                  value: Format.formatPrice(200, context)),
                              verticalSpace(20),
                              // Row(
                              //   children: [
                              //     Text(
                              //       'summary.patientDetails'.tr(),
                              //       style: Theme.of(context).textTheme.bodyLarge,
                              //     ),
                              //     Spacer(),
                              //     Icon(
                              //       IconBroken.Edit,
                              //       color: AppColors.secondaryColor,
                              //       size: 20,
                              //     ),
                              //   ],
                              // ),
                              Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                              verticalSpace(10),
                              model.patient == null
                                  ? SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppointmentDetailsItem(
                                            title: 'summary.name',
                                            value: model.patient!.name!),
                                        verticalSpace(10),
                                        AppointmentDetailsItem(
                                            title: 'summary.age',
                                            value: Format.formatNumber(
                                                model.patient!.age!, context)),
                                        verticalSpace(10),
                                        AppointmentDetailsItem(
                                          title: 'summary.gender',
                                          value:
                                              'appointments.${model.patient!.gender!}'
                                                  .tr(),
                                        ),
                                        verticalSpace(10),
                                        AppointmentDetailsItem(
                                          title: 'summary.phoneNumber',
                                          value: Format.formatNumber(
                                              int.parse(model.patient!.phone!),
                                              context),
                                        ),
                                        verticalSpace(10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'summary.problem'.tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            verticalSpace(10),
                                            Text(
                                              model.patient!.problem!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ])),
        );
      },
    );
  }
}

Widget cnacelAppointment(
    BuildContext context, Appointment appointment, UserModel user) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'appointments.cancelAppointment'.tr(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.red,
              ),
        ),
        verticalSpace(20),
        Text(
          textAlign: TextAlign.center,
          'appointments.cancelAppointmentMessage'.tr(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                backgroundColor: AppColors.mainColor.withAlpha(20),
                buttonColor: AppColors.mainColor,
                buttonName: 'appointments.no'.tr(),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                width: MediaQuery.of(context).size.width > 500 ? 200 : 150,
                paddingVirtical: 5,
                paddingHorizental: 10),
            horizontalSpace(10),
            CustomButton(
              buttonName: 'appointments.yes'.tr(),
              onPressed: () {
                context.pushNamed(AppRoutes.cancelAppointment, arguments: {
                  'appointment': appointment,
                  'context': context,
                  'user': user
                });
              },
              width: MediaQuery.of(context).size.width > 500 ? 200 : 150,
              paddingVirtical: 5,
              paddingHorizental: 10,
            )
          ],
        ),
      ],
    ),
  );
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
