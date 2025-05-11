import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/map/widgets/map_clinic_card.dart';
import 'package:medical_system/features/map/widgets/map_doctor_card.dart';
import 'package:medical_system/features/map/widgets/map_lab_card.dart';

class MapLocation extends StatefulWidget {
  const MapLocation({
    super.key,
    required this.appointment,
  });
  // final Clinic clinic;

  final Appointment appointment;

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  final Location location = Location();

  StreamSubscription<LocationData>? _locationSubscription;

  LatLng? currentLocation;

  LatLng? destinationLocation;

  final MapController mapController = MapController();

  List<LatLng>? routePoints = [];

  @override
  void initState() {
    super.initState();
    initialize(widget.appointment);
  }

  Future<void> initialize(Appointment appointment) async {
    bool hasPermission = await _checkPermission();
    if (!hasPermission) {
      log('Location permission not granted');
    } else {
      await startFollowingUser();
      await moveToCurrentLocation();
      if (appointment.clinic != null &&
          appointment.clinic!.lattitude != null &&
          appointment.clinic!.longitude != null) {
        final clinic = appointment.clinic!;
        setState(() {
          destinationLocation = LatLng(clinic.lattitude!, clinic.longitude!);
        });
        await fitchRoute();
      } else if (appointment.hospital != null &&
          appointment.hospital!.location['longtude'] != null &&
          appointment.hospital!.location['latitude'] != null) {
        print('location ${appointment.hospital!.location}');
        final clinic = appointment.hospital!;
        setState(() {
          destinationLocation = LatLng(
              double.parse(clinic.location['latitude']!),
              double.parse(clinic.location['longtude']!));
        });
        await fitchRoute();
      } else if (appointment.lab!.location != null &&
          appointment.lab!.location!['longtude'] != null &&
          appointment.lab!.location!['latitude'] != null) {
        final clinic = appointment.lab!;
        log(clinic.location.toString());
        setState(() {
          destinationLocation = LatLng(
              double.parse(clinic.location!['latitude']!),
              double.parse(clinic.location!['longtude']!));
          log('destinationLocation888 ${destinationLocation.toString()}');
        });
        await fitchRoute();
      }
    }
  }

  Future<void> startFollowingUser() async {
    _locationSubscription = location.onLocationChanged.listen((locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          currentLocation =
              LatLng(locationData.latitude!, locationData.longitude!);
          fitchRoute();

          log(currentLocation.toString());
        });
      }
      //fitchRoute();
    });
  }

  Future<void> moveToCurrentLocation() async {
    // Ensure the map is initialized first and wait for the FlutterMap to be built.
    if (currentLocation != null) {
      log('moveToCurrentLocation');
      Future.delayed(const Duration(milliseconds: 500), () {
        mapController.move(currentLocation!, 15.0);
      });
    } else {
      getCurrentLocation();
    }
  }

  Future<void> fitchRoute() async {
    log('currentLocation $currentLocation');
    log('destinationLocation $destinationLocation');
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
          if (!mounted) return;

          _decodePolyline(coordinates);
        }
      } else {
        log('Failed to fetch route: ${response.statusCode}');
      }
    }
  }

  void _decodePolyline(String encoded) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> points = polylinePoints.decodePolyline(encoded);
    setState(() {
      routePoints = points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    });
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

  Future<void> getCurrentLocation() async {
    try {
      log('getCurrentLocation');
      final position = await location.getLocation();
      setState(() {
        currentLocation = LatLng(position.latitude!, position.longitude!);
      });
      moveToCurrentLocation();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          moveToCurrentLocation();
        },
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: currentLocation ?? const LatLng(51.5, -0.09),
              initialZoom: 13.0,
              onTap: (tapPosition, point) {
                setState(() {
                  destinationLocation = point;
                });
                fitchRoute(); // Re-fetch the route when destination changes
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),

              // Current Location Layer - moved inside FlutterMap
              CurrentLocationLayer(
                  rotateAnimationDuration: const Duration(seconds: 1),
                  rotateAnimationCurve: Curves.linear,
                  style: LocationMarkerStyle(
                      headingSectorColor: AppColors.mainColor,
                      markerDirection: MarkerDirection.heading,
                      showAccuracyCircle: true,
                      showHeadingSector: false,
                      marker: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://i.imgur.com/MK3O6JU.png'),
                              fit: BoxFit.cover,
                            )),
                      )),
                  alignDirectionStream: location.onLocationChanged,
                  indicators: LocationMarkerIndicators(
                    permissionDenied: const Icon(
                      Icons.location_off,
                      color: Colors.red,
                      size: 40.0,
                    ),
                    serviceDisabled: const Icon(
                      Icons.location_off,
                      color: Colors.red,
                      size: 40.0,
                    ),
                    permissionRequesting: const Icon(
                      Icons.location_searching,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                  positionStream: location.onLocationChanged.map(
                    (locationData) => LocationMarkerPosition(
                      latitude: locationData.latitude!,
                      longitude: locationData.longitude!,
                      accuracy: locationData.accuracy!,
                    ),
                  )),
              // Destination Marker Layer
              if (destinationLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                        width: 80.0,
                        height: 80.0,
                        point: destinationLocation!,
                        child: Icon(
                          Icons.location_on,
                          color: AppColors.mainColor,
                          size: 40.0,
                        )),
                  ],
                ),
              // Route Polyline Layer
              if (routePoints != null &&
                  routePoints!.isNotEmpty &&
                  currentLocation != null &&
                  destinationLocation != null)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routePoints!,
                      color: AppColors.secondaryColor,
                      strokeWidth: 4,
                    ),
                  ],
                ),
            ],
          ),
          widget.appointment.clinic != null
              ? MapDoctorCard(appointment: widget.appointment)
              : widget.appointment.hospital != null
                  ? MapClinicCard(appointment: widget.appointment)
                  : MapLabCard(
                      appointment: widget.appointment,
                    ),
        ],
      ),
    );
  }
}
