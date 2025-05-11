part of 'offers_cubit.dart';

@immutable
sealed class OffersState {}

final class OffersInitial extends OffersState {}

final class GetOffersLoading extends OffersState {}

final class GetOffersSuccess extends OffersState {}

final class GetOffersError extends OffersState {
  final String errMessage;
  GetOffersError({required this.errMessage});
}
