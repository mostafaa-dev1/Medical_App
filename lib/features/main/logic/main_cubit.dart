import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/connectivity/connectivity_helper.dart';
import 'package:medical_system/core/networking/services/local_databases/secure_storage.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/appointments/logic/appointments_cubit.dart';
import 'package:medical_system/features/appointments/ui/appointments.dart';
import 'package:medical_system/features/clinics/data/model/clinic_model.dart';
import 'package:medical_system/features/home/data/data/home_data.dart';
import 'package:medical_system/features/home/data/models/spcilailties_model.dart';
import 'package:medical_system/features/home/ui/home.dart';
import 'package:medical_system/features/medical_histroy/logic/ai_medical_histroy_cubit.dart';
import 'package:medical_system/features/medical_histroy/medical_histroy.dart';
import 'package:medical_system/features/offers/data/data_services/offers_data.dart';
import 'package:medical_system/features/offers/data/model/offers_model.dart';
import 'package:medical_system/features/profile/logic/profile_cubit.dart';
import 'package:medical_system/features/profile/profile.dart';

part 'main_state.dart';

enum FitchType {
  spcilailties,
  offers,
  upcoming,
  all,
  user,
}

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  UserModel user = UserModel();
  final _homeData = HomeData();
  final _offersData = OffersData();

  Future<void> getCashedData() async {
    final results = await Future.wait([
      Storage.readValue(key: 'id'),
      Storage.readValue(key: 'uid'),
      Storage.readValue(key: 'firstName'),
      Storage.readValue(key: 'lastName'),
      Storage.readValue(key: 'email'),
      Storage.readValue(key: 'image'),
      Storage.readValue(key: 'phone'),
      Storage.readValue(key: 'dateOfBirth'),
      Storage.readValue(key: 'gender'),
      Storage.readValue(key: 'adresses'),
    ]);
    log(results.toString());

    log(results[7].toString());
    // Handle potential null values
    user = UserModel(
      id: results[0],
      uid: results[1],
      firstName: results[2],
      lastName: results[3],
      email: results[4],
      image: results[5],
      phone: results[6],
      dateOfBirth: DateFormat('dd-MM-yyyy').parse(results[7]!),
      //dateOfBirth: results[7) results[7],
      gender: results[8],
      //addresses: parsedAddresses,
    );
    emit(CashedDataLoaded());
    log(user.toJson().toString());
  }

  Future<void> init() async {
    await getUser();

    if (await ConnectivityHelper.checkConnection()) {
      categoryIndex = 0;
      emit(MainLoading());
      getUpcomingAppointments();
      getSpcilailties(
        type: 'Doctor',
      );
      getOffers('Doctor');
      getUserLocation();

      emit(MainSuccess());
    } else {
      emit(NoInternetConnection(
        'dialog.noInternetConnection',
      ));
    }
  }

  Future<void> getUser() async {
    try {
      // Fetch all storage values in parallel
      final results = await Future.wait([
        Storage.readValue(key: 'id'),
        Storage.readValue(key: 'uid'),
        Storage.readValue(key: 'firstName'),
        Storage.readValue(key: 'lastName'),
        Storage.readValue(key: 'email'),
        Storage.readValue(key: 'image'),
        Storage.readValue(key: 'phone'),
        Storage.readValue(key: 'dateOfBirth'),
        Storage.readValue(key: 'gender'),
        Storage.readValue(key: 'adresses'),
      ]);
      log(results.toString());
      //List<Address> parsedAddresses = [];
      // if (results[8] != null) {
      //   try {
      //     List<dynamic> decodedList = jsonDecode(results[8] as String);
      //     parsedAddresses =
      //         decodedList.map((e) => Address.fromJson(e)).toList();
      //   } catch (e) {
      //     log("Failed to parse addresses: $e");
      //   }
      // }

      // Handle potential null values
      user = UserModel.fromJson({
        'id': results[0],
        'uid': results[1],
        'first_name': results[2],
        'last_name': results[3],
        'email': results[4],
        'image': results[5],
        'phone': results[6],
        'date_of_birth': results[7],
        'gender': results[8],
        'adresses': [],
      });
      emit(PersonalInfoSuccess());
      log(user.toJson().toString());
    } catch (e) {
      log(e.toString());
      emit(MainFailure(e.toString()));
    }
  }

  List<Widget> pages(UserModel user) {
    return [
      Home(),
      BlocProvider(
        create: (context) => AppointmentsCubit()
          ..getAppointments(
              eqKey2: 'type',
              eqValue2: 'Upcoming',
              index: 0,
              patientId: user.id!),
        child: Appointments(
          user: user,
        ),
      ),
      BlocProvider(
        create: (context) =>
            AiMedicalHistroyCubit()..getMedicalHistory(user.id!),
        child: MedicalHistroy(),
      ),
      BlocProvider(
        create: (context) => ProfileCubit(),
        child: Profile(
          user: user,
        ),
      ),
    ];
  }

  int pageIndex = 0;
  int categoryIndex = 0;
  void changeCategoryIndex(int index) {
    categoryIndex = index;
    if (index == 1) {
      getSpcilailties(
        type: 'Lab',
      );
      getOffers('Lab');
    } else if (index == 0) {
      getSpcilailties(
        type: 'Doctor',
      );
      getOffers('Doctor');
    } else if (index == 2) {
      getClinics();
      getOffers('Clinic');
    }
    emit(AppCategoryIndexChanged());
  }

  void changePageIndex(int index) {
    pageIndex = index;

    emit(AppPageIndexChanged());
  }

  bool isUpcomingLoading = false;
  bool isSpcilailtiesLoading = false;
  bool isOffersLoading = false;

  AppointmentList? upcomingVisits;
  Future<void> getUpcomingAppointments() async {
    emit(GetUpcomingAppointmentsLoading());
    // Fetch upcoming appointments
    isUpcomingLoading = true;
    final response = await _homeData.getUpcomingVisits(patientId: user.id!);
    response.fold((l) {
      isUpcomingLoading = false;
      log(l.toString());
      emit(MainFailure(l));
    }, (r) {
      log('data ${r.toString()}');
      isUpcomingLoading = false;
      upcomingVisits = AppointmentList.fromJson(r);
      emit(GetUpcomingAppointmentsSuccess());
    });
  }

  SpcilailtiesList spcilailties = SpcilailtiesList(
    spcilailties: [],
  );
  Future<void> getSpcilailties({
    required String type,
  }) async {
    emit(GetSpcilailtiesLoading());
    // Fetch upcoming appointments
    isSpcilailtiesLoading = true;
    // Fetch upcoming appointments
    final response = await _homeData.getSpecialitiesData(
      type: type,
      limit: 12,
    );
    response.fold((l) {
      isSpcilailtiesLoading = false;
      log(l.toString());
      emit(MainFailure(l));
    }, (r) {
      isSpcilailtiesLoading = false;
      spcilailties = SpcilailtiesList.fromJson(r);
      emit(GetSpcilailtiesSuccess());
    });
  }

  List<ClinicInfo>? clinics;

  Future<void> getClinics() async {
    emit(GetSpcilailtiesLoading());
    // Fetch upcoming appointments
    isSpcilailtiesLoading = true;
    // Fetch upcoming appointments
    final response = await _homeData.getClinics();
    response.fold((l) {
      isSpcilailtiesLoading = false;
      log(l.toString());
      emit(MainFailure(l));
    }, (r) {
      log(r.toString());
      clinics = r.map((e) => ClinicInfo.fromJson(e)).toList();
      isSpcilailtiesLoading = false;
      spcilailties = SpcilailtiesList(spcilailties: []);
      for (var element in r) {
        spcilailties.spcilailties!.add(SpcilailtiesModel(
          specialty: element['Hospitals']['name'],
          specialtyAr: element['Hospitals']['name_ar'],
          image: element['Hospitals']['image'],
        ));
      }
      log(spcilailties.spcilailties![0].toString());
      emit(GetSpcilailtiesSuccess());
    });
  }

  OffersList offers = OffersList(
    offers: [],
  );
  Future<void> getOffers(String provider) async {
    emit(GetOffersLoading());
    isOffersLoading = true;
    // Fetch upcoming appointments
    final response = await _offersData.getOffersWithLimit(
      provider: provider,
    );
    response.fold((l) {
      isOffersLoading = false;
      log(l.toString());
      emit(MainFailure(l));
    }, (r) {
      isOffersLoading = false;
      offers = OffersList.fromJson(r);
      emit(GetOffersSuccess());
    });
  }

  Position? userPosition;
  DateTime? lastLocationCheckTime;
  Future<Position?> determinePosition() async {
    if (userPosition != null &&
        lastLocationCheckTime != null &&
        DateTime.now().difference(lastLocationCheckTime!).inMinutes < 5) {
      return userPosition!;
    } else {
      bool serviceEnabled;
      LocationPermission permission;
      print('determinePosition');
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log('Location services are disabled.');
        emit(LocationError(
          'dialog.locationDisabled',
        ));
      }
      if (serviceEnabled) {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            emit(LocationError(
              'dialog.locationDenied',
            ));
          }
        }

        if (permission == LocationPermission.deniedForever) {
          emit(LocationError(
            'dialog.locationDeniedForever',
          ));
        }
        Position position = await Geolocator.getCurrentPosition();
        log(position.toString());
        return position;
      }
    }
    return null;
  }

  Future<void> getUserLocation() async {
    try {
      userPosition = await determinePosition();
      // await getCityAndStreetName();
      lastLocationCheckTime = DateTime.now();
      // know city and street name

      emit(LocationSuccess());
    } catch (e) {
      log(e.toString());
      emit(LocationError(e.toString()));
    }
  }

  DateTime parseDateTime(String date, String time) {
    String hour = time.split(':')[0];
    String minute = time.split(':')[1];
    String dateTimeString = '$date $hour:$minute:00';
    //log(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString).toString());
    log(DateTime.parse(dateTimeString).toString());
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString);
  }

  Future<bool> hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      log(result.toString());
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  void openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }
  // Future<void> getCityAndStreetName() async {
  //   if (userPosition != null) {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         userPosition!.latitude, userPosition!.longitude);
  //     Placemark place = placemarks[0];

  //     String city = place.locality!;
  //     String streetName = place.street!;
  //     print('User Position: ${place.administrativeArea}');
  //     print('City: $city');
  //     print('Street Name: $streetName');
  //   }
  // }

  DoctorsList doctors = DoctorsList();
  Future<void> getNearbyDoctors() async {
    final response = await _homeData.getNearByDoctors();
    response.fold((l) {
      print(l);
      emit(MainFailure(l));
    }, (r) {
      print('doctors list $r');
      doctors = DoctorsList.fromJson(r);
      //emit(GetOffersSuccess());
    });
  }
}
