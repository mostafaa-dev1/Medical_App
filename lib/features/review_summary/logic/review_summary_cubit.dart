import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/connectivity/connectivity_helper.dart';
import 'package:medical_system/core/networking/notifications/local_notifications.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/core/networking/services/payment/paymob.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';

part 'review_summary_state.dart';

class ReviewSummaryCubit extends Cubit<ReviewSummaryState> {
  ReviewSummaryCubit() : super(ReviewSummaryInitial());

  final _supabaseServices = SupabaseServices();
  final _paymob = Paymob();
  int? paymentIndex;
  TextEditingController discountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void changePaymentIndex(int index) {
    paymentIndex = index;
    emit(ChangePaymentIndex());
  }

  int discountAmount = 0;
  int? total;
  Future<void> discount({required String providerId, required int fee}) async {
    emit(DiscountLoadnig());
    final response = await _supabaseServices.getDataWithTwoeq('Discounts', '*',
        'code', discountController.text, 'provider_id', providerId);
    response.fold((l) {
      emit(DiscountError(l));
    }, (response) {
      double discount = (int.parse(response[0]['percentage']) * fee) / 100;
      discountAmount = fee - discount.toInt();
      total = fee - discountAmount;
      emit(DiscountSuccess());
    });
  }

  Future<void> payWithCard(String amount, UserModel user) async {
    try {
      emit(PayWithCardLoading());
      String amountInCents = (int.parse(amount) * 100).toString();
      String token = await _paymob.getToken();
      int orderId =
          await _paymob.getOrderId(token: token, amount: amountInCents);
      String paymentKey = await _paymob.getPaymentKey(
          token: token, orderId: orderId, amount: amountInCents, user: user);
      emit(PayWithCardSuccess(paymentKey));
    } catch (e) {
      emit(PayWithCardError(e.toString()));
    }
  }

  Future<void> confirm(int amount, UserModel user, Appointment appointment,
      Clinic clinic, String doctor) async {
    if (!await ConnectivityHelper.checkConnection()) {
      emit(NoInternetConnection('dialog.noInternetConnection'));
      return;
    }
    if (paymentIndex == 1) {
      payWithCard(amount.toString(), user);
    } else {
      bookAppointment(appointment, 'Cash', 'Pending', user, clinic, doctor);
      //cash
    }
  }

  Future<void> bookAppointment(Appointment appointment, String paymentType,
      String status, UserModel user, Clinic clinic, String doctor) async {
    log(clinic.id!);
    appointment.doctorId = clinic.doctorId;
    appointment.clinicId = clinic.id;
    appointment.paymentMethod = paymentType;
    appointment.status = status;
    appointment.patientId = user.id;
    appointment.type = 'Upcoming';

    // appointment.date =
    //     DateFormat('yyyy-MM-dd').parse(appointment.date.toString());
    // log(appointment.toJson().toString());
    log(appointment.toJson().toString());
    emit(BookAppointmentLoading());
    final response = await _supabaseServices.setData(
        table: 'Appointments', data: appointment.toJson());
    response.fold((error) {
      print(error);
      emit(BookAppointmentError(error));
    }, (response) {
      secheduleNotification(response, doctor);
      //log(response.toString());
      emit(BookAppointmentSuccess());
    });
  }

  Future<void> secheduleNotification(
      Map<String, dynamic> response, String doctor) async {
    await LocalNotifications.showNotification(
      title: 'dialog.bookSuccess'.tr(),
      body: 'dialog.appointmentBooked'.tr(),
    );
    await LocalNotifications.secheduleNotification(
      title: 'dialog.todayAppointment'.tr(),
      body: '${'dialog.dontMissTodayAppointment'.tr()}$doctor',
      dateTime: parseDateTime(
        response['date'].toString(),
        response['time'].toString(),
      ).subtract(
        const Duration(hours: 1),
      ),
      id: response['id'],
    );
    await LocalNotifications.secheduleNotification(
      title: 'dialog.onHourToAppointment'.tr(),
      body: '${'dialog.dontMissAppointment'.tr()}$doctor',
      dateTime: parseDate(
        response['date'].toString(),
      ),
      id: response['id'] + 100000,
    );
  }

  DateTime parseDateTime(String date, String time) {
    String hour = time.split(':')[0];
    String minute = time.split(':')[1];
    String dateTimeString = '$date $hour:$minute:00';
    log(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString).toString());
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString);
  }

  DateTime parseDate(String date) {
    return DateFormat('yyyy-MM-dd').parse(date);
  }
}
