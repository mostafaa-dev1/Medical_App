import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/core/widgets/overlay_loading.dart';
import 'package:medical_system/core/widgets/stepper.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/review_summary/logic/review_summary_cubit.dart';

class ReviewSummary extends StatelessWidget {
  const ReviewSummary(
      {super.key,
      required this.user,
      required this.appointment,
      required this.doctor});
  final UserModel user;
  final Appointment appointment;
  final Clinic doctor;

  @override
  Widget build(BuildContext context) {
    print(doctor.id);
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
        }
        if (state is PayWithCardSuccess) {
          context.loaderOverlay.hide();
          print(state.paymentKey);
          context.pushNamed(AppRoutes.paymentWebView, arguments: {
            'token': state.paymentKey,
            'appointment': appointment,
            'user': user,
            'doctor': doctor,
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
                    String doctorName = LanguageChecker.isArabic(context)
                        ? '${'appointments.dr'.tr()}${doctor.doctor!.firstNameAr} ${doctor.doctor!.lastNameAr}'
                        : '${'appointments.dr'.tr()}${doctor.doctor!.firstName} ${doctor.doctor!.lastName}';
                    cubit.confirm(cubit.total ?? doctor.fee!, user, appointment,
                        doctor, doctorName);
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
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                          bottom: 10,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
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
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Theme.of(context).colorScheme.primary,
                                  border: Border.all(
                                    color: AppColors.mainColor,
                                  )),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: doctor.doctor!.image == null
                                      ? Image.asset('assets/images/user.png')
                                      : CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: doctor.doctor!.image!)),
                            ),
                            horizontalSpace(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${'appointments.dr'.tr()} ${LanguageChecker.isArabic(context) ? doctor.doctor!.firstNameAr : doctor.doctor!.firstName} ${LanguageChecker.isArabic(context) ? doctor.doctor!.lastNameAr : doctor.doctor!.lastName}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                verticalSpace(5),
                                Text(
                                  'specialities.${doctor.doctor!.specialty}'
                                      .tr(),
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
                                      '${'government.${doctor.government}'.tr()} | ${'city.${doctor.city}'.tr()} | ${doctor.street}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
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
                              'summary.appointmentDetails'.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            verticalSpace(10),
                            ReviewSummaryItem(
                                title: 'summary.date'.tr(),
                                value: Format.formatDate(
                                    appointment.date!, context)),
                            verticalSpace(5),
                            ReviewSummaryItem(
                                title: 'summary.time'.tr(),
                                value: Format.formatSringTime(
                                    appointment.time!, context)),
                            verticalSpace(5),
                            ReviewSummaryItem(
                              title: 'summary.paymentMethod'.tr(),
                              value: cubit.paymentIndex == 1
                                  ? 'summary.card'.tr()
                                  : cubit.paymentIndex == 2
                                      ? 'summary.cash'.tr()
                                      : '',
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                          child: Form(
                            key: cubit.formKey,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextFrom(
                                      hintText: 'summary.promoCode'.tr(),
                                      controller: cubit.discountController,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'summary.promoCodeRequired'
                                              .tr();
                                        }
                                        return null;
                                      }),
                                ),
                                horizontalSpace(10),
                                CustomButton(
                                  onPressed: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.discount(
                                          providerId: doctor.doctor!.id!,
                                          fee: doctor.fee!);
                                    }
                                  },
                                  buttonName: 'summary.apply'.tr(),
                                  paddingHorizental: 10,
                                  paddingVirtical: 10,
                                  width: 100,
                                ),
                              ],
                            ),
                          )),
                      Container(
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
                      ),
                      verticalSpace(10),
                      Container(
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
                              value: Format.formatPrice(doctor.fee, context),
                            ),
                            verticalSpace(5),
                            ReviewSummaryItem(
                              title: 'summary.discount'.tr(),
                              value: Format.formatPrice(
                                  cubit.discountAmount, context),
                            ),
                            verticalSpace(5),
                            ReviewSummaryItem(
                              title: 'summary.total'.tr(),
                              value: Format.formatPrice(
                                  cubit.total ?? doctor.fee, context),
                            )
                          ],
                        ),
                      ),
                      Container(
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
                            children: [
                              verticalSpace(10),
                              Text(
                                'summary.patientDetails'.tr(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              verticalSpace(10),
                              ReviewSummaryItem(
                                title: 'summary.name'.tr(),
                                value: appointment.patient!.name!,
                              ),
                              verticalSpace(5),
                              ReviewSummaryItem(
                                title: 'summary.age'.tr(),
                                value: Format.formatNumber(
                                    appointment.patient!.age, context),
                              ),
                              verticalSpace(5),
                              ReviewSummaryItem(
                                title: 'summary.gender'.tr(),
                                value:
                                    'summary.${appointment.patient!.gender!.toLowerCase()}'
                                        .tr(),
                              ),
                              verticalSpace(5),
                              ReviewSummaryItem(
                                title: 'summary.phoneNumber'.tr(),
                                value: '+20${user.phone!}',
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    verticalSpace(5),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        appointment.patient!.problem ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
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
