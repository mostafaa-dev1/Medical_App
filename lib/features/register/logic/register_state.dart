part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}

final class RegisterSuccess extends RegisterState {}

final class ObscurePassword extends RegisterState {}
