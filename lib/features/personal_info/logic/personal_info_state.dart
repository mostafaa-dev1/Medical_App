part of 'personal_info_cubit.dart';

@immutable
sealed class PersonalInfoState {}

final class GenderIndexChanged extends PersonalInfoState {}

final class GenderSelected extends PersonalInfoState {}

final class PersonalInfoInitial extends PersonalInfoState {}

final class UploadImageLoading extends PersonalInfoState {}

final class UploadImageError extends PersonalInfoState {
  final String message;
  UploadImageError(this.message);
}

final class UploadImageSuccess extends PersonalInfoState {}

final class GetImageUrlLoading extends PersonalInfoState {}

final class UploadingImageError extends PersonalInfoState {
  final String message;
  UploadingImageError(this.message);
}

final class UploadingImageSuccess extends PersonalInfoState {}

final class DateSelected extends PersonalInfoState {}
