import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/features/search/data/searsh_data/search_data.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final _searchData = SearchData();
  Map<String, dynamic> filterValues = {};

  Clinics doctors = Clinics();
  Future<void> search(
      {String? spciality,
      String? gov,
      String? rate,
      String? price,
      String? firstName,
      bool? withSearch,
      bool? ar}) async {
    if (withSearch ?? false) {
      return;
    }
    filterValues = {
      'speciality': spciality,
      'government': gov,
      'rate': rate,
      'price': price
    };
    emit(SearchLoading());
    log(filterValues.toString());
    final response = await _searchData.search(
        spciality: spciality,
        rate: rate,
        gov: gov,
        price: price,
        firstName: firstName,
        ar: ar);
    response.fold((l) {
      log(l);
      emit(SearchError(l));
    }, (r) async {
      log(r.toString());
      log(r.length.toString());

      Position? userPosition = await _getUserLocation();
      log(userPosition.toString());
      List<Map<String, dynamic>> sortedDoctors = [];
      // Step 3: Sort Doctors by Distance
      if (userPosition != null) {
        log('with location');
        sortedDoctors = _sortDoctorsByDistance(
            userPosition.latitude, userPosition.longitude, r);
        doctors = Clinics.fromJson(sortedDoctors);
      } else {
        doctors = Clinics.fromJson(r);
      }

      emit(SearchSuccess());
    });
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
        emit(LocationError(
            "Location services are disabled, please enable them for better search results."));
        return null;
      }

      // Request permission if not granted
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationError(
              "Location permissions are denied, please allow them for better search results."));
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError(
            "Location permissions are permanently denied, we cannot request permissions, so we can't provide better search results."));
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
    doctors.sort((a, b) {
      double distanceA = Geolocator.distanceBetween(userLat, userLng,
          a['lattitude'].toDouble(), a['longitude'].toDouble());
      double distanceB = Geolocator.distanceBetween(userLat, userLng,
          b['lattitude'].toDouble(), b['longitude'].toDouble());
      return distanceA.compareTo(distanceB); // Sort by nearest
    });

    return doctors;
  }

  void applyFilters(Map<String, dynamic> filters) {
    log(filters.toString());
    filterValues = {};
    filterValues = filters;
    log(filterValues.toString());
    emit(SearchSuccess());

    search(
      spciality: filters['speciality'] == 'All' ? null : filters['speciality'],
      rate: filters['rateing'] == 'All' ? null : filters['rateing'],
      gov: filters['government'] == 'All' ? null : filters['government'],
      price: filters['price'],
    );
  }
}
