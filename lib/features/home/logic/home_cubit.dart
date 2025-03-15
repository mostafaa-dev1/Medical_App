import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:medical_system/core/models/address.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/services/local_databases/secure_storage.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  User user = User(
    id: '',
    uid: '',
    firstName: '',
    lastName: '',
    email: '',
    image: '',
    phone: '',
    dateOfBirth: DateTime.now(),
    gender: '',
    adresses: [],
  );

  Future<void> init() async {
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
      List<Address> parsedAddresses = [];
      if (results[8] != null) {
        try {
          List<dynamic> decodedList = jsonDecode(results[8] as String);
          parsedAddresses =
              decodedList.map((e) => Address.fromJson(e)).toList();
        } catch (e) {
          log("Failed to parse addresses: $e");
        }
      }

      // Handle potential null values
      user = User(
        id: results[0] ?? '',
        uid: results[1] ?? '',
        firstName: results[2] ?? '',
        lastName: results[3] ?? '',
        email: results[4] ?? '',
        image: results[5] ?? '',
        phone: results[6] ?? '',
        dateOfBirth: _parseDate(results[7]),
        gender: results[8] ?? '',
        adresses: parsedAddresses,
      );
      log(user.toJson().toString());
      emit(HomeSuccess());
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  DateTime _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return DateTime.now();
    try {
      return DateTime.parse(dateStr);
    } catch (_) {
      return DateTime.now(); // Fallback if parsing fails
    }
  }
}
