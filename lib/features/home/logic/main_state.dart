part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class MainLoading extends MainState {}

final class MainSuccess extends MainState {}

final class MainFailure extends MainState {
  final String error;
  MainFailure(this.error);
}

final class GetUpcomingAppointmentsLoading extends MainState {}

final class GetUpcomingAppointmentsSuccess extends MainState {}

final class GetUpcomingAppointmentsError extends MainState {
  final String error;
  GetUpcomingAppointmentsError(this.error);
}

final class GetSpcilailtiesLoading extends MainState {}

final class GetSpcilailtiesSuccess extends MainState {}

final class GetSpcilailtiesError extends MainState {
  final String error;
  GetSpcilailtiesError(this.error);
}

final class GetOffersLoading extends MainState {}

final class GetOffersSuccess extends MainState {}

final class GetOffersError extends MainState {
  final String error;
  GetOffersError(this.error);
}

final class PersonalInfoSuccess extends MainState {}

final class AppPageIndexChanged extends MainState {}

final class CashedDataLoaded extends MainState {}

final class AppCategoryIndexChanged extends MainState {}

final class LocationError extends MainState {
  final String error;
  LocationError(this.error);
}

final class LocationSuccess extends MainState {}

final class LocationLoading extends MainState {}

final class NoInternetConnection extends MainState {
  final String error;
  NoInternetConnection(this.error);
}
