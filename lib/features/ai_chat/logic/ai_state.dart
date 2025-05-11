part of 'ai_cubit.dart';

@immutable
sealed class AiState {}

final class AiInitial extends AiState {}

final class AiLoading extends AiState {}

final class AiSuccess extends AiState {}

final class AiMessageAdded extends AiState {}

final class AiError extends AiState {
  final String errMessage;

  AiError({required this.errMessage});
}

final class FitchDoctorsLoading extends AiState {}

final class FitchDoctorsSuccess extends AiState {}

final class FitchDoctorsError extends AiState {
  final String errMessage;

  FitchDoctorsError({required this.errMessage});
}

final class LocationError extends AiState {
  final String errMessage;

  LocationError({required this.errMessage});
}

final class NoInternetConnection extends AiState {}
