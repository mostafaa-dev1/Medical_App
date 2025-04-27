part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapError extends MapState {
  final String message;
  MapError(this.message);
}

final class MapSuccess extends MapState {}

final class MapLocationUpdated extends MapState {
  final LatLng? currentLocation;
  MapLocationUpdated(this.currentLocation);
}

final class MapRouteUpdated extends MapState {
  final List<LatLng>? routePoints;
  MapRouteUpdated(this.routePoints);
}

final class MapLoading extends MapState {}
