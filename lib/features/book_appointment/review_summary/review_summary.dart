import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/logic/app_cubit.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/core/widgets/overlay_loading.dart';
import 'package:medical_system/core/widgets/stepper.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/book_appointment/review_summary/logic/review_summary_cubit.dart';
import 'package:medical_system/features/book_appointment/review_summary/widgets/select_payment_method.dart';
import 'package:medical_system/features/book_appointment/review_summary/widgets/summary_appointment_details.dart';
import 'package:medical_system/features/book_appointment/review_summary/widgets/summary_clinic.dart';
import 'package:medical_system/features/book_appointment/review_summary/widgets/summary_discount.dart';
import 'package:medical_system/features/book_appointment/review_summary/widgets/summary_doctor.dart';
import 'package:medical_system/features/book_appointment/review_summary/widgets/summary_lab.dart';
import 'package:medical_system/features/book_appointment/review_summary/widgets/summary_patient_details.dart';
import 'package:medical_system/features/book_appointment/review_summary/widgets/summary_payment_details.dart';

class ReviewSummary extends StatelessWidget {
  const ReviewSummary({
    super.key,
    required this.user,
    required this.appointment,
    //required this.doctor,
  });
  final UserModel user;
  final Appointment appointment;
  //final Clinic doctor;
  String getProviderName(BuildContext context) {
    if (appointment.clinic != null) {
      if (LanguageChecker.isArabic(context)) {
        return '${'appointments.dr'.tr()}${appointment.doctor!.firstNameAr} ${appointment.doctor!.lastNameAr}';
      } else {
        return '${'appointments.dr'.tr()}${appointment.doctor!.firstName} ${appointment.doctor!.lastName}';
      }
    } else if (appointment.hospital != null) {
      if (LanguageChecker.isArabic(context)) {
        return appointment.hospital!.clinic!.nameAr;
      } else {
        return appointment.hospital!.clinic!.name;
      }
    } else if (appointment.lab != null) {
      if (LanguageChecker.isArabic(context)) {
        return appointment.lab!.lab!.nameAr!;
      } else {
        return appointment.lab!.lab!.name!;
      }
    } else {
      return 'Unknown';
    }
  }

  int getFee() {
    if (appointment.clinic != null) {
      return appointment.clinic!.fee!;
    } else if (appointment.hospital != null) {
      return appointment.doctor!.fee!;
    } else if (appointment.lab != null) {
      return appointment.lab!.fee!;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewSummaryCubit, ReviewSummaryState>(
      listener: (context, state) {
        if (state is BookAppointmentLoading) {
          context.loaderOverlay.show();
        }
        if (state is PayWithCardLoading) {
          context.loaderOverlay.show();
        }

        if (state is BookAppointmentSuccess) {
          context.loaderOverlay.hide();
          showCustomDialog(
            context: context,
            dialogType: DialogType.success,
            message: 'appointments.appointmentSuccess'.tr(),
            onConfirmPressed: () {
              context.pushNamedAndRemoveUntil(AppRoutes.mainScreen);
            },
            confirmButtonName: 'dialog.ok'.tr(),
            title: 'dialog.bookSuccess'.tr(),
          );
          context.read<AppCubit>().addNotification(
              content: 'Appointment has been booked successfully',
              contentAr: 'تم حجز الموعد بنجاح',
              patientId: user.id!,
              type: 'Booked');
        }
        if (state is PayWithCardSuccess) {
          context.loaderOverlay.hide();
          context.pushNamed(AppRoutes.paymentWebView, arguments: {
            'token': state.paymentKey,
            'appointment': appointment,
            'user': user,
            'context': context
          });
        }
        if (state is PayWithCardError) {
          context.loaderOverlay.hide();
          showCustomDialog(
              context: context,
              message: 'appointments.appointmentError'.tr(),
              title: 'dialog.oops'.tr(),
              onConfirmPressed: () => context.pop(),
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.error);
        }
        if (state is BookAppointmentError) {
          context.loaderOverlay.hide();
          showCustomDialog(
              context: context,
              message: 'appointments.appointmentError'.tr(),
              title: 'dialog.bookError'.tr(),
              onConfirmPressed: () {
                context.pop();
              },
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.error);
        } else if (state is NoInternetConnection) {
          showCustomDialog(
            context: context,
            message: 'dialog.noInternetConnection'.tr(),
            title: 'dialog.oops',
            onConfirmPressed: () {
              context.pop();
            },
            confirmButtonName: 'dialog.ok'.tr(),
            dialogType: DialogType.error,
          );
        }
      },
      builder: (context, state) {
        var cubit = context.read<ReviewSummaryCubit>();
        int? selectedPaymentIndex = cubit.paymentIndex;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'appointments.bookAppointment'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: CustomButton(
                isLoading: state is BookAppointmentLoading ||
                    state is PayWithCardLoading,
                onPressed: () {
                  if (selectedPaymentIndex != null) {
                    cubit.confirm(cubit.total ?? appointment.fee ?? 0, user,
                        appointment, getProviderName(context));
                  } else {
                    showCustomDialog(
                      context: context,
                      message: '',
                      title: 'dialog.selectPaymentMethod'.tr(),
                      onConfirmPressed: () => context.pop(),
                      confirmButtonName: 'dialog.ok'.tr(),
                      dialogType: DialogType.warning,
                    );
                  }
                },
                buttonName: 'summary.confirm'.tr(),
                width: double.infinity,
                paddingVirtical: 5,
                height: 40,
                paddingHorizental: 10,
              ),
            ),
          ],
          body: LoaderOverlay(
            overlayWidgetBuilder: (context2) => OverlayLoading(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppointmentStepper(
                    index: 2,
                    text: 'summary.reviewSummary'.tr(),
                  ),
                  verticalSpace(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appointment.clinic != null
                          ? SummaryDoctor(appointment: appointment)
                          : appointment.hospital != null
                              ? SummaryClinic(appointment: appointment)
                              : SummaryLab(appointment: appointment),
                      SummaryAppointmentDetails(appointment: appointment),
                      SummaryPaymentDetails(
                        fee: appointment.fee ?? 0,
                      ),
                      SummaryDiscount(appointment: appointment),
                      SelectPaymentMethod(),
                      verticalSpace(10),
                      SummaryPatientDetails(patient: appointment.patient!),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
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
