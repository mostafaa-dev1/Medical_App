part of 'laboratories_cubit.dart';

@immutable
sealed class LaboratoriesState {}

final class LaboratoriesInitial extends LaboratoriesState {}

final class LaboratoriesLoading extends LaboratoriesState {}

final class LaboratoriesSuccess extends LaboratoriesState {}

final class LaboratoriesError extends LaboratoriesState {
  final String errMessage;
  LaboratoriesError({required this.errMessage});
}

final class ChangeServiceIndexState extends LaboratoriesState {}

final class AddToLabCartState extends LaboratoriesState {}

final class LocationError extends LaboratoriesState {
  final String errMessage;
  LocationError({required this.errMessage});
}
