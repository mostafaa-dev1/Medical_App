import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/services/auth/auth_service.dart';
import 'package:medical_system/core/networking/services/local_databases/shared_preferances.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());
  final auth = AuthService();
  UserModel? user;

  TextEditingController otpController = TextEditingController();

  Future<void> sendOtp({
    required String email,
  }) async {
    DateTime? lastSend =
        DateTime.tryParse(CashHelper.getString(key: 'lastSend') ?? '');
    if (lastSend != null) {
      if (DateTime.now().difference(lastSend).inMinutes < 1) {
        emit(OtpSendError(
          errorMessage:
              '${'Auth.sendAgainIn'.tr()}${60 - lastSend.difference(DateTime.now()).inSeconds}${'Auth.seconds'.tr()}',
        ));
        return;
      } else {
        emit(OtpSendLoading());
        EmailOTP.config(
          appName: 'Delma',
          otpType: OTPType.numeric,
          expiry: 60000,
          emailTheme: EmailTheme.v6,
          appEmail: 'm0stafa.ma7moud03@gmail.com',
          otpLength: 4,
        );
        var res = await EmailOTP.sendOTP(email: email);
        print(res);
        if (res) {
          emit(OtpSendSuccess());
          CashHelper.putString(
              key: 'lastSend', value: DateTime.now().toString());
        } else {
          emit(OtpSendError(
            errorMessage: 'Failed to send OTP',
          ));
        }
      }
    } else {
      emit(OtpSendLoading());
      EmailOTP.config(
        appName: 'Delma',
        otpType: OTPType.numeric,
        expiry: 60000,
        emailTheme: EmailTheme.v6,
        appEmail: 'm0stafa.ma7moud03@gmail.com',
        otpLength: 4,
      );
      var res = await EmailOTP.sendOTP(email: email);
      print(res);
      if (res) {
        emit(OtpSendSuccess());
        CashHelper.putString(key: 'lastSend', value: DateTime.now().toString());
      } else {
        emit(OtpSendError(
          errorMessage: 'Failed to send OTP',
        ));
      }
    }
  }

  Future<void> verifyOtp(
      {required String email,
      required String password,
      required bool justVerify}) async {
    emit(OtpVerifyLoading());

    var res = EmailOTP.verifyOTP(otp: otpController.text);
    print(res);
    if (res) {
      if (justVerify) {
        forgetPassword(email);
        emit(OtpVerifySuccess());
        return;
      }
      emit(OtpVerifySuccess());
      await register(email: email, password: password);
    } else {
      emit(OtpVerifyError(
        errorMessage: 'Failed to verify OTP',
      ));
    }
  }

  Future<void> register(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    final result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    result.fold((l) {
      emit(RegisterError(
        errorMessage: l,
      ));
    }, (response) {
      user = UserModel(
        id: '',
        uid: response!.uid,
        firstName: "",
        lastName: "",
        gender: "",
        dateOfBirth: DateTime.now(),
        email: response.email!,
        image: response.photoURL ?? "",
        phone: response.phoneNumber ?? "",
        addresses: [],
      );
      log(user!.toJson().toString());
      emit(RegisterSuccess());
    });
  }

  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());
    final result = await auth.forgetPassword(email);
    result.fold((l) {
      emit(ForgetPasswordError(errorMessage: l));
    }, (r) {
      emit(ForgetPasswordSuccess());
    });
  }
}
