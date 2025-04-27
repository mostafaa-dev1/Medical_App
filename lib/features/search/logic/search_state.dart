part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

final class SearchSuccess extends SearchState {}

final class LocationError extends SearchState {
  final String message;
  LocationError(this.message);
}
