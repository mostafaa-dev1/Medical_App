part of 'services_cubit.dart';

@immutable
sealed class ServicesState {}

final class ServicesInitial extends ServicesState {}

final class ServicesLoading extends ServicesState {}

final class ServicesSuccess extends ServicesState {}

final class ServicesError extends ServicesState {
  final String error;

  ServicesError(this.error);
}

final class PickImage extends ServicesState {}

final class NoInternetConnection extends ServicesState {
  final String error;
  NoInternetConnection(this.error);
}
