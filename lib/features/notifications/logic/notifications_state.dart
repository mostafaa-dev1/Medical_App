part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoading extends NotificationsState {}

final class NotificationsSuccess extends NotificationsState {}

final class NotificationsError extends NotificationsState {
  final String errMessage;
  NotificationsError({required this.errMessage});
}

final class ReadNotificationLoading extends NotificationsState {}

final class ReadNotificationSuccess extends NotificationsState {}

final class ReadNotificationError extends NotificationsState {
  final String errMessage;
  ReadNotificationError({required this.errMessage});
}
