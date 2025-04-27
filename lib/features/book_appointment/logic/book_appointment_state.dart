part of 'book_appointment_cubit.dart';

@immutable
sealed class BookAppointmentState {}

final class BookAppointmentInitial extends BookAppointmentState {}

final class AvailableTimesState extends BookAppointmentState {}

final class AvailableDaysState extends BookAppointmentState {}

final class GetAvailableTimesLoading extends BookAppointmentState {}

final class GetAvailableTimesSuccess extends BookAppointmentState {}

final class BookAppointmentError extends BookAppointmentState {
  final String error;
  BookAppointmentError(this.error);
}

final class RescheduleAppointmentLoading extends BookAppointmentState {}

final class RescheduleAppointmentSuccess extends BookAppointmentState {}

final class RescheduleAppointmentError extends BookAppointmentState {
  final String error;
  RescheduleAppointmentError(this.error);
}
