part of 'doctor_profile_cubit.dart';

@immutable
sealed class DoctorProfileState {}

final class DoctorProfileInitial extends DoctorProfileState {}

final class GetReviewsLoading extends DoctorProfileState {}

final class GetReviewsSuccess extends DoctorProfileState {}

final class GetReviewsError extends DoctorProfileState {
  final String error;
  GetReviewsError(this.error);
}
