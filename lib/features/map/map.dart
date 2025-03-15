import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController mapController = MapController();
  // LocationData? currentLocation;
  // List<LatLng> routePoints = [];
  // List<Marker> markers = [];
  // final String orsApiKey =
  //'5b3ce3597851110001cf6248b53114c3a0df46b381a69b890dc978c3';

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
    _inizializeLocation();
  }

  @override
  void dispose() {
    _locationSubscription!.cancel();
    mapController.dispose();
    super.dispose();
  }

  StreamSubscription<LocationData>? _locationSubscription;
  final Location location = Location();
  bool loading = false;
  LatLng? _currentLocation;
  LatLng? _destinationLocation;
  List<LatLng> _routePoints = [];
  Future<void> _inizializeLocation() async {
    bool hasPermission = await _checkPermission();
    if (!hasPermission) return;

    getCurrentLocation();

    _locationSubscription = location.onLocationChanged.listen((locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        // ✅ Check if widget is still in the tree

        setState(() {
          _currentLocation =
              LatLng(locationData.latitude!, locationData.longitude!);
          loading = false;
        });
      }
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

  void _fetchRoute() async {
    if (_currentLocation != null && _destinationLocation != null) {
      final url = Uri.parse("http://router.project-osrm.org/route/v1/driving/"
          "${_currentLocation!.longitude},${_currentLocation!.latitude};"
          "${_destinationLocation!.longitude},${_destinationLocation!.latitude}"
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
        throw Exception('Failed to fetch route: ${response.statusCode}');
      }
    }
  }

  void _decodePolyline(String encoded) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> points = polylinePoints.decodePolyline(encoded);
    setState(() {
      _routePoints = points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    });
  }

  Future<void> _moveToCurrentLocation() async {
    if (_currentLocation != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        mapController.move(_currentLocation!, 15.0);
      });
    }
  }

  void getCurrentLocation() async {
    try {
      log('getCurrentLocation');
      final position = await location.getLocation();
      setState(() {
        _currentLocation = LatLng(position.latitude!, position.longitude!);
      });
      _moveToCurrentLocation();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clinic Location',
            style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: _currentLocation ?? LatLng(51.5, -0.09),
              initialZoom: 15.0,
              onTap: (tapPosition, point) => {
                setState(() {
                  _destinationLocation = point;
                }),
                _fetchRoute(),
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                // subdomains: ['a', 'b', 'c'],
              ),
              CurrentLocationLayer(
                alignDirectionStream: location.onLocationChanged,
                style: LocationMarkerStyle(
                    marker: DefaultLocationMarker(
                      color: AppColors.secondaryColor,
                    ),
                    markerSize: Size(35, 35),
                    markerDirection: MarkerDirection.heading),
              ),
              if (_destinationLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _destinationLocation!,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              if (_routePoints.isNotEmpty &&
                  _currentLocation != null &&
                  _destinationLocation != null)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      color: AppColors.secondaryColor,
                      strokeWidth: 4,
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 220,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(20),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Theme.of(context).colorScheme.primary,
                              border: Border.all(
                                color: AppColors.mainColor,
                              )),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image(
                                image: AssetImage('assets/images/doctor.png'),
                                fit: BoxFit.fill,
                              )),
                        ),
                        horizontalSpace(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. John Doe',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            verticalSpace(5),
                            Text(
                              'Brain and Nerves doctor',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            verticalSpace(5),
                            Text(
                              'Egypt/Cairo',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).colorScheme.primary,
                              border: Border.all(
                                color: AppColors.mainColor,
                              )),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppColors.mainColor,
                              ),
                              horizontalSpace(5),
                              Text(
                                '4.5',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(30),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                              buttonName: 'Back'.tr(),
                              onPressed: () {},
                              backgroundColor:
                                  AppColors.mainColor.withAlpha(10),
                              buttonColor: AppColors.mainColor,
                              width: MediaQuery.of(context).size.width > 500
                                  ? 200
                                  : 150,
                              paddingVirtical: 10,
                              paddingHorizental: 10),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          child: CustomButton(
                              buttonName: 'Open in Maps'.tr(),
                              onPressed: () {},
                              width: MediaQuery.of(context).size.width > 500
                                  ? 200
                                  : 150,
                              paddingVirtical: 10,
                              paddingHorizental: 10),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _moveToCurrentLocation();
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
