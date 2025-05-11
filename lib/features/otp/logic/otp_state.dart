part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpSendLoading extends OtpState {}

final class OtpSendSuccess extends OtpState {}

final class OtpSendError extends OtpState {
  final String errorMessage;
  OtpSendError({required this.errorMessage});
}

final class OtpVerifyLoading extends OtpState {}

final class OtpVerifySuccess extends OtpState {}

final class OtpVerifyError extends OtpState {
  final String errorMessage;
  OtpVerifyError({required this.errorMessage});
}

final class RegisterLoading extends OtpState {}

final class RegisterSuccess extends OtpState {}

final class RegisterError extends OtpState {
  final String errorMessage;
  RegisterError({required this.errorMessage});
}

final class ForgetPasswordLoading extends OtpState {}

final class ForgetPasswordSuccess extends OtpState {}

final class ForgetPasswordError extends OtpState {
  final String errorMessage;
  ForgetPasswordError({required this.errorMessage});
}
