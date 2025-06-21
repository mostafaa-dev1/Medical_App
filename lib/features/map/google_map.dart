import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:medical_system/core/constants/app_keys.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/map/widgets/map_clinic_card.dart';
import 'package:medical_system/features/map/widgets/map_doctor_card.dart';
import 'package:medical_system/features/map/widgets/map_lab_card.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key, required this.appointment});
  final Appointment appointment;

  @override
  State<GoogleMapPage> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  late StreamSubscription<LocationData>? _locationSubscription;
  // LatLng currentLocation = LatLng(30.252908, 31.248449);
  // LatLng targetLocation = LatLng(31.232715, 30.044453);
  LatLng getDestinationLocation() {
    if (widget.appointment.clinic != null) {
      final destination = widget.appointment.clinic;
      return LatLng(destination!.lattitude!, destination.longitude!);
    } else if (widget.appointment.hospital != null) {
      final destination = widget.appointment.hospital!.location;
      return LatLng(double.parse(destination['latitude']!),
          double.parse(destination['longtude']!));
    } else if (widget.appointment.lab != null) {
      final destination = widget.appointment.lab!.location;
      return LatLng(double.parse(destination!['latitude']!),
          double.parse(destination['longtude']!));
    } else {
      return LatLng(0, 0);
    }
  }

  final PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];

  Future<void> getPolyline(LocationData currentLocation) async {
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: AppKeys.mapApi,
        request: PolylineRequest(
          origin: PointLatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          ),
          destination: PointLatLng(
            getDestinationLocation().latitude,
            getDestinationLocation().longitude,
          ),
          mode: TravelMode.driving,
          optimizeWaypoints: true,
        ),
      );
      if (result.points.isNotEmpty) {
        setState(() {
          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  final Location _location = Location();
  LocationData? _locationData;
  void getCurrentLocation() async {
    try {
      LocationData ulocation = await _location.getLocation();
      setState(() {
        _locationData = ulocation;
      });
      await getPolyline(ulocation);
      // calculateDistanceInKm(LatLng(ulocation.latitude!, ulocation.longitude!),
      //     getDestinationLocation());

      final GoogleMapController controller = await _controller.future;
      if (!mounted) return;

      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(ulocation.latitude!, ulocation.longitude!),
            zoom: 15,
            // bearing: 59,
            // tilt: 45,
          ),
        ),
      );
      _locationSubscription =
          _location.onLocationChanged.listen((newLocation) async {
        // double currentCameraPosition = await controller.getZoomLevel();
        // await controller.animateCamera(
        //   CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //       target: LatLng(newLocation.latitude!, newLocation.longitude!),
        //       zoom: currentCameraPosition,
        //       // bearing: 59,
        //       // tilt: 45,
        //     ),
        //   ),
        // );
        setState(() {
          _locationData = newLocation;
          distanceInKm = calculateDistanceInKm(
            LatLng(newLocation.latitude!, newLocation.longitude!),
            getDestinationLocation(),
          );
        });
        //await getPolyline(ulocation);
      });
    } catch (e) {
      print(e);
    }
  }

  double? distanceInKm;

  double calculateDistanceInKm(LatLng start, LatLng end) {
    const earthRadius = 6371; // km
    final dLat = _degToRad(end.latitude - start.latitude);
    final dLon = _degToRad(end.longitude - start.longitude);

    final a = (sin(dLat / 2) * sin(dLat / 2)) +
        cos(_degToRad(start.latitude)) *
            cos(_degToRad(end.latitude)) *
            (sin(dLon / 2) * sin(dLon / 2));

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degToRad(double deg) => deg * pi / 180;

  @override
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.future.then((value) => value.dispose());
    _locationSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              onMapCreated: (controller) async {
                if (!_controller.isCompleted) {
                  _controller.complete(controller);
                }
                await Future.delayed(
                    Duration(milliseconds: 300)); // let map settle
                getCurrentLocation();
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0),
                zoom: 15,
              ),
              markers: {
                if (_locationData != null)
                  Marker(
                    infoWindow: const InfoWindow(
                      title: 'Target Location',
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueMagenta),
                    markerId: const MarkerId('currentLocation'),
                    position: LatLng(
                        _locationData!.latitude!, _locationData!.longitude!),
                  ),
                Marker(
                  infoWindow: const InfoWindow(
                    title: 'Current Location',
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  markerId: const MarkerId('startLocation'),
                  position: LatLng(getDestinationLocation().latitude,
                      getDestinationLocation().longitude),
                ),
                // Marker(
                //   infoWindow: const InfoWindow(title: 'Target Location'),
                //   icon: BitmapDescriptor.defaultMarkerWithHue(
                //       BitmapDescriptor.hueGreen),
                //   markerId: const MarkerId('targetLocation'),
                //   position: targetLocation,
                // ),
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  color: AppColors.mainColor,
                  width: 6,
                  points: polylineCoordinates,
                ),
              }),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (_locationData != null) {
                      final controller = await _controller.future;
                      await controller.animateCamera(
                        duration: Duration(milliseconds: 500),
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(_locationData!.latitude!,
                                _locationData!.longitude!),
                            zoom: 15,
                            // bearing: 59,
                            // tilt: 45,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.shadow,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Center(
                          child: Icon(
                        Icons.my_location,
                        size: 30,
                        color: AppColors.mainColor,
                      ))),
                ),
                verticalSpace(10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          widget.appointment.clinic != null
                              ? MapDoctorCard(appointment: widget.appointment)
                              : widget.appointment.hospital != null
                                  ? MapClinicCard(
                                      appointment: widget.appointment)
                                  : MapLabCard(appointment: widget.appointment),
                        ],
                      ),
                      verticalSpace(10),
                      if (distanceInKm != null)
                        // Text(
                        //   'Distance: ${distanceInKm!.toStringAsFixed(2)} km',
                        //   style:
                        //       TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        // ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 10, vertical: 5),
                        //   decoration: BoxDecoration(
                        //     color: AppColors.mainColor.withAlpha(20),
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: Text('${distanceInKm!.toStringAsFixed(2)} km',
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .bodySmall!
                        //           .copyWith(
                        //             color: AppColors.mainColor,
                        //           )),
                        // ),
                        verticalSpace(10),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                                buttonName: 'appointments.back'.tr(),
                                onPressed: () {
                                  context.pop();
                                },
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
                                reightIcon: false,
                                icon: Icons.my_location,
                                buttonName: 'appointments.showOnMap'.tr(),
                                onPressed: () async {
                                  await MapsLauncher.launchCoordinates(
                                      getDestinationLocation().latitude,
                                      getDestinationLocation().longitude);
                                },
                                width: MediaQuery.of(context).size.width > 500
                                    ? 200
                                    : 150,
                                paddingVirtical: 10,
                                paddingHorizental: 10),
                          ),
                        ],
                      )
                      // ElevatedButton.icon(
                      //   onPressed: () async {
                      //     if (_locationData != null) {
                      //       final controller = await _controller.future;
                      //       controller.animateCamera(
                      //         CameraUpdate.newLatLng(
                      //           LatLng(_locationData!.latitude!,
                      //               _locationData!.longitude!),
                      //         ),
                      //       );
                      //     }
                      //   },
                      //   icon: Icon(Icons.my_location),
                      //   label: Text('Go to My Location'),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: AppColors.mainColor,
                      //     foregroundColor: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
