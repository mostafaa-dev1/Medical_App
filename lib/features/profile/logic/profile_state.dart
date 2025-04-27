part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class DateSelected extends ProfileState {}

final class UpdatePersonalInfoLoading extends ProfileState {}

final class UpdatePersonalInfoSuccess extends ProfileState {
  final UserModel user;
  UpdatePersonalInfoSuccess(this.user);
}

final class UpdatePersonalInfoError extends ProfileState {
  final String error;
  UpdatePersonalInfoError(this.error);
}

final class UpdateProfileImageLoading extends ProfileState {}

final class UpdateProfileImageSuccess extends ProfileState {
  UpdateProfileImageSuccess();
}

final class UpdateProfileImageError extends ProfileState {
  final String error;
  UpdateProfileImageError(this.error);
}

final class ImagePicked extends ProfileState {}

final class ImageRemoved extends ProfileState {}
