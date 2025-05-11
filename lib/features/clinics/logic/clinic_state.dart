part of 'clinic_cubit.dart';

@immutable
sealed class ClinicState {}

final class ClinicInitial extends ClinicState {}

final class ClinicLoading extends ClinicState {}

final class ClinicSuccess extends ClinicState {}

final class ClinicError extends ClinicState {
  final String errMessage;
  ClinicError({required this.errMessage});
}

final class FitchDoctorsLoading extends ClinicState {}

final class FitchDoctorsSuccess extends ClinicState {}

final class FitchDoctorsError extends ClinicState {
  final String errMessage;
  FitchDoctorsError({required this.errMessage});
}

final class SelectIndexState extends ClinicState {}

final class LocationError extends ClinicState {
  final String errMessage;
  LocationError({required this.errMessage});
}
