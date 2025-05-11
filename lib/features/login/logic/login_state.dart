part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserModel user;
  LoginSuccess(this.user);
}

final class ObscurePassword extends LoginState {}

final class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

final class ForgetPasswordLoading extends LoginState {}

final class ForgetPasswordSuccess extends LoginState {}

final class ForgetPasswordError extends LoginState {
  final String message;
  ForgetPasswordError(this.message);
}
