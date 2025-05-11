import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/features/clinics/data/model/clinic_model.dart';
import 'package:medical_system/features/clinics/data/services/clinic_services.dart';
import 'package:meta/meta.dart';

part 'clinic_state.dart';

class ClinicCubit extends Cubit<ClinicState> {
  ClinicCubit() : super(ClinicInitial());

  final _clinicData = ClinicServices();

  List<ClinicInfo>? clinics;
  Map<String, dynamic> filterValues = {};

  Future<void> getClinics({
    String? name,
    bool? ar,
    String? rate,
    String? gov,
    String? city,
  }) async {
    emit(ClinicLoading());
    filterValues = {
      'name': name,
      'rate': rate,
      'government': gov,
      'city': city
    };
    clinics = [];
    final result = await _clinicData.getClinics(
      gov: gov,
      city: city,
    );
    result.fold((l) {
      emit(ClinicError(errMessage: l));
    }, (data) async {
      if (data.isNotEmpty) {
        Position? userPosition = await _getUserLocation();
        log(userPosition.toString());
        List<Map<String, dynamic>> sortedClinics = [];
        // Step 3: Sort Doctors by Distance
        if (userPosition != null) {
          log('with location');
          sortedClinics = _sortDoctorsByDistance(
              userPosition.latitude, userPosition.longitude, data);
          clinics = sortedClinics.map((e) => ClinicInfo.fromJson(e)).toList();
        } else {
          clinics = data.map((e) => ClinicInfo.fromJson(e)).toList();
        }
      }
      emit(ClinicSuccess());
    });
  }

  void applyFilters(Map<String, dynamic> filters) {
    log(filters.toString());
    filterValues = {};
    filterValues = filters;
    log(filterValues.toString());
    emit(ClinicSuccess());

    getClinics(
      rate: filters['rateing'] == 'All' ? null : filters['rateing'],
      gov: filters['government'] == 'All' ? null : filters['government'],
      city: filters['city'] == 'All' ? null : filters['city'],
    );
  }

  int selectedIndex = 0;

  void selectIndex(int index) {
    selectedIndex = index;
    emit(SelectIndexState());
  }

  List<Doctor>? doctors;
  void getDoctors(String spciality, String hospitalId, int index) async {
    emit(FitchDoctorsLoading());
    selectedIndex = index;
    final response = await _clinicData.getDcotors(
        specialty: spciality, hospitalId: hospitalId);
    response.fold((l) {
      emit(FitchDoctorsError(errMessage: l));
    }, (r) {
      doctors = r.map((e) => Doctor.fromJson(e['Doctors'])).toList();
      emit(FitchDoctorsSuccess());
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
      double userLat, double userLng, List<Map<String, dynamic>> data) {
    data.sort((a, b) {
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

    return data;
  }
}
