import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical_system/features/laboratories/data/model/labs_model.dart';
import 'package:medical_system/features/laboratories/data/services/labs_data.dart';

part 'laboratories_state.dart';

class LaboratoriesCubit extends Cubit<LaboratoriesState> {
  LaboratoriesCubit() : super(LaboratoriesInitial());

  final _labsData = LabsData();
  TextEditingController searchController = TextEditingController();
  Map<String, dynamic> filterValues = {};

  List<LabsInfo>? labs;

  Future<void> getLabs(
      {String? specialty,
      String? rate,
      String? gov,
      String? name,
      bool? ar,
      bool? withSearch,
      String? city}) async {
    if (withSearch ?? false) {
      return;
    }
    emit(LaboratoriesLoading());
    labs = [];
    filterValues = {
      'speciality': specialty,
      'rating': rate,
      'government': gov,
      'city': city
    };
    final response = await _labsData.getLabs(
      specialty: specialty!,
      rate: rate,
      gov: gov,
      city: city,
    );
    response.fold((l) {
      emit(LaboratoriesError(errMessage: l));
    }, (data) async {
      if (data.isNotEmpty) {
        log(data.toString());
        Position? userPosition = await _getUserLocation();
        log(userPosition.toString());
        List<Map<String, dynamic>> sortedLabs = [];
        // Step 3: Sort Doctors by Distance
        if (userPosition != null) {
          log('with location');
          sortedLabs = _sortDoctorsByDistance(
              userPosition.latitude, userPosition.longitude, data);
          labs = sortedLabs.map((e) => LabsInfo.fromJson(e)).toList();
        } else {
          labs = data.map((e) => LabsInfo.fromJson(e)).toList();
        }
      }
      emit(LaboratoriesSuccess());
    });
  }

  void applyFilters(Map<String, dynamic> filters) {
    log(filters.toString());
    filterValues = {};
    filterValues = filters;
    log(filterValues.toString());
    emit(LaboratoriesSuccess());

    getLabs(
      specialty: filters['speciality'] == 'All' ? null : filters['speciality'],
      rate: filters['rating'] == 'All' ? null : filters['rating'],
      gov: filters['government'] == 'All' ? null : filters['government'],
      city: filters['city'] == 'All' ? null : filters['city'],
    );
  }

  int selectedIndex = 0;
  void changeServiceIndex(int index) {
    selectedIndex = index;
    emit(ChangeServiceIndexState());
  }

  List<LabServices> cart = [];
  List<int> cartIndexes = [];
  double total = 0;

  void addToCart(LabServices service, int index) {
    if (cartIndexes.contains(index)) {
      cart.removeWhere((element) => element.service == service.service);
      cartIndexes.remove(index);
      total -= double.parse(service.price);
    } else {
      cart.add(service);
      cartIndexes.add(index);
      total += double.parse(service.price);
    }

    emit(AddToLabCartState());
  }

  Position? userPosition;
  DateTime? lastLocationCheckTime;
  Future<Position?> _getUserLocation() async {
    // Check if the location is already fetched and not too old
    if (userPosition != null &&
        lastLocationCheckTime != null &&
        DateTime.now().difference(lastLocationCheckTime!).inMinutes < 5) {
      return userPosition;
    } else {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // await Geolocator.openLocationSettings();
        // serviceEnabled = await Geolocator.isLocationServiceEnabled();
        // if (!serviceEnabled) {
        // }
        emit(LocationError(errMessage: "dialog.locationDisabled"));
        return null;
      }

      // Request permission if not granted
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationError(errMessage: "dialog.locationDenied"));
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError(errMessage: "dialog.locationDeniedForever"));
        //return Future.error('Location permissions are permanently denied');
        return null;
      }
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      userPosition = position;
      lastLocationCheckTime = DateTime.now();

      // Get current position
      return position;
    }
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  List<Map<String, dynamic>> _sortDoctorsByDistance(
      double userLat, double userLng, List<Map<String, dynamic>> doctors) {
    log(doctors[0]['location'].toString());
    doctors.sort((a, b) {
      double distanceA = Geolocator.distanceBetween(
          userLat,
          userLng,
          double.parse(a['location']['latitude']),
          double.parse(a['location']['longtude']));
      double distanceB = Geolocator.distanceBetween(
          userLat,
          userLng,
          double.parse(b['location']['latitude']),
          double.parse(b['location']['longtude']));
      return distanceA.compareTo(distanceB); // Sort by nearest
    });

    return doctors;
  }
}
