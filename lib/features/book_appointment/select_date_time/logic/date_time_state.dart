part of 'date_time_cubit.dart';

@immutable
sealed class DateTimeState {}

final class DateTimeInitial extends DateTimeState {}

final class AvailableTimesState extends DateTimeState {}

final class AvailableDaysState extends DateTimeState {}

final class GetAvailableTimesLoading extends DateTimeState {}

final class GetAvailableTimesSuccess extends DateTimeState {}

final class BookAppointmentError extends DateTimeState {
  final String error;
  BookAppointmentError(this.error);
}

final class RescheduleAppointmentLoading extends DateTimeState {}

final class RescheduleAppointmentSuccess extends DateTimeState {}

final class RescheduleAppointmentError extends DateTimeState {
  final String error;
  RescheduleAppointmentError(this.error);
}
