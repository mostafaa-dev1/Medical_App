import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/services/local_databases/secure_storage.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  User user = User(
    uid: '',
    name: '',
    email: '',
    image: '',
    phone: '',
    dateOfBirth: DateTime.now(),
    gender: '',
  );

  Future<void> init() async {
    try {
      // Fetch all storage values in parallel
      final results = await Future.wait([
        Storage.readValue(key: 'uid'),
        Storage.readValue(key: 'name'),
        Storage.readValue(key: 'email'),
        Storage.readValue(key: 'image'),
        Storage.readValue(key: 'phone'),
        Storage.readValue(key: 'dateOfBirth'),
        Storage.readValue(key: 'gender'),
      ]);

      // Handle potential null values
      user = User(
        uid: results[0] ?? '',
        name: results[1] ?? '',
        email: results[2] ?? '',
        image: results[3] ?? '',
        phone: results[4] ?? '',
        dateOfBirth: _parseDate(results[5]),
        gender: results[6] ?? '',
      );
      log(user!.toJson().toString());
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
