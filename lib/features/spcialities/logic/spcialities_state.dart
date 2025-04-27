part of 'spcialities_cubit.dart';

@immutable
sealed class SpcialtiesState {}

final class SpcialtiesInitial extends SpcialtiesState {}

final class GetSpecialitiesLoading extends SpcialtiesState {}

final class GetSpecialitiesSuccess extends SpcialtiesState {}

final class GetSpecialitiesFailure extends SpcialtiesState {
  final String error;

  GetSpecialitiesFailure({required this.error});
}
