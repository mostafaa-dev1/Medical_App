part of 'appointments_cubit.dart';

@immutable
sealed class AppointmentsState {}

final class AppointmentsInitial extends AppointmentsState {}

final class GetAppointmentsLoading extends AppointmentsState {}

final class GetAppointmentsSuccess extends AppointmentsState {}

final class GetAppointmentsError extends AppointmentsState {
  final String message;
  GetAppointmentsError(this.message);
}

final class CancelAppointmentLoading extends AppointmentsState {}

final class CancelAppointmentSuccess extends AppointmentsState {}

final class CancelAppointmentError extends AppointmentsState {
  final String message;
  CancelAppointmentError(this.message);
}

final class RescheduleAppointmentLoading extends AppointmentsState {}

final class RescheduleAppointmentSuccess extends AppointmentsState {}

final class RescheduleAppointmentError extends AppointmentsState {
  final String message;
  RescheduleAppointmentError(this.message);
}

final class SelectCancelIndexState extends AppointmentsState {}
