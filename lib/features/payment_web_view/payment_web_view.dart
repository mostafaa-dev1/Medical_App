import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/review_summary/logic/review_summary_cubit.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView(
      {super.key,
      required this.token,
      required this.appointment,
      required this.userModel,
      required this.doctor});
  final String token;
  final Appointment appointment;
  final UserModel userModel;
  final Clinic doctor;

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  InAppWebViewController? webViewController;
  void startPayment() {
    webViewController?.loadUrl(
        urlRequest: URLRequest(
            url: WebUri.uri(Uri.parse(
                'https://accept.paymob.com/api/acceptance/iframes/890003?payment_token=${widget.token}'))));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startPayment();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewSummaryCubit, ReviewSummaryState>(
      listener: (context, state) {
        if (state is BookAppointmentSuccess) {
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
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: InAppWebView(
            onWebViewCreated: (controller) {
              webViewController = controller;
              startPayment();
            },
            initialSettings: InAppWebViewSettings(javaScriptEnabled: true),
            onLoadStop: (controller, url) {
              if (url != null &&
                  url.queryParameters.containsKey('success') &&
                  url.queryParameters['success'] == 'true') {
                String doctorName = LanguageChecker.isArabic(context)
                    ? '${'appointments.dr'.tr()}${widget.doctor.doctor!.firstNameAr} ${widget.doctor.doctor!.lastNameAr}'
                    : '${'appointments.dr'.tr()}${widget.doctor.doctor!.firstName} ${widget.doctor.doctor!.lastName}';
                context.read<ReviewSummaryCubit>().bookAppointment(
                    widget.appointment,
                    'Visa',
                    'Confirmed',
                    widget.userModel,
                    widget.doctor,
                    doctorName);
                log('Payment Successful');
              } else if (url != null &&
                  url.queryParameters.containsKey('success') &&
                  url.queryParameters['success'] == 'false') {
                log('Payment Failed');
              }
            },
          ),
        );
      },
    );
  }
}
