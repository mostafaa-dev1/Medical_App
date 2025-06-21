part of 'ai_medical_histroy_cubit.dart';

@immutable
sealed class AiMedicalHistroyState {}

final class AiMedicalHistroyInitial extends AiMedicalHistroyState {}

final class AiLoading extends AiMedicalHistroyState {}

final class AiError extends AiMedicalHistroyState {
  final String errMessage;
  AiError({required this.errMessage});
}

final class AiSuccess extends AiMedicalHistroyState {}

final class NoInternetConnection extends AiMedicalHistroyState {}

final class AiMessageAdded extends AiMedicalHistroyState {}

final class AiFinished extends AiMedicalHistroyState {}

final class AddAnswer extends AiMedicalHistroyState {}

final class YesORNo extends AiMedicalHistroyState {}

final class UploadMedicalHistroyLoading extends AiMedicalHistroyState {}

final class UploadMedicalHistroySuccess extends AiMedicalHistroyState {}

final class UploadMedicalHistroyError extends AiMedicalHistroyState {
  final String errMessage;
  UploadMedicalHistroyError({required this.errMessage});
}

final class GetMedicalHistoryLoading extends AiMedicalHistroyState {}

final class GetMedicalHistorySuccess extends AiMedicalHistroyState {}

final class GetMedicalHistoryError extends AiMedicalHistroyState {}
