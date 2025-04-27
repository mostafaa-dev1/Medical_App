import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:medical_system/core/models/doctor_model.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  final Location location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  LatLng? currentLocation;
  LatLng? destinationLocation;
  final MapController mapController = MapController();
  List<LatLng>? routePoints = [];

  Future<void> initialize(Clinic clinic) async {
    emit(MapLoading());
    bool hasPermission = await _checkPermission();
    if (!hasPermission) {
      emit(MapError('Location permission not granted'));
    } else {
      await startFollowingUser();
      await moveToCurrentLocation();
      if (clinic.lattitude != null && clinic.longitude != null) {
        destinationLocation = LatLng(clinic.lattitude!, clinic.longitude!);
        await fitchRoute();
      }
    }
    emit(MapSuccess());
  }

  Future<void> startFollowingUser() async {
    _locationSubscription = location.onLocationChanged.listen((locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        currentLocation =
            LatLng(locationData.latitude!, locationData.longitude!);
        emit(MapLocationUpdated(currentLocation));
      }
    });
  }

  Future<void> moveToCurrentLocation() async {
    // Ensure the map is initialized first and wait for the FlutterMap to be built.
    if (currentLocation != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapController.move(currentLocation!, 15.0);
      });
    }
  }

  Future<void> fitchRoute() async {
    if (currentLocation != null && destinationLocation != null) {
      final url = Uri.parse("http://router.project-osrm.org/route/v1/driving/"
          "${currentLocation!.longitude},${currentLocation!.latitude};"
          "${destinationLocation!.longitude},${destinationLocation!.latitude}"
          "?overview=full&geometries=polyline");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['routes'].isNotEmpty) {
          final coordinates = data['routes'][0]['geometry'];

          _decodePolyline(coordinates);
        }
      } else {
        emit(MapError('Failed to fetch route: ${response.statusCode}'));
      }
    }
  }

  void _decodePolyline(String encoded) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> points = polylinePoints.decodePolyline(encoded);
    routePoints =
        points.map((point) => LatLng(point.latitude, point.longitude)).toList();
    emit(MapRouteUpdated(routePoints));
  }

  Future<bool> _checkPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false; // ⛔ Service not enabled, return early
      }
    }

    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return false; // ⛔ Permission denied, return early
      }
    }

    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> serviceEnabled() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    return serviceEnabled;
  }

  Future<void> openLocationSettings() async {
    await location.requestService();
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
