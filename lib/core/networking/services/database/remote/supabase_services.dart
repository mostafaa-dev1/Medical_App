import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/local_databases/secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  // Step 1: Create a private static instance
  static final SupabaseServices _instance = SupabaseServices._internal();

  // Step 2: Provide a factory constructor to return the same instance
  factory SupabaseServices() {
    print('SupabaseServices instance created');
    return _instance;
  }

  // Step 3: Private named constructor (prevents multiple instances)
  SupabaseServices._internal();

  // Supabase client instance
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Either<String, List<Map<String, dynamic>>>> getData(
      String table, String query) async {
    try {
      final response = await _supabase.from(table).select(query);
      return Right(response);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getDataWithLimit(
      String table, String query) async {
    try {
      final response = await _supabase.from(table).select(query).limit(9);
      if (response.isEmpty) {
        return Left('Auth.unexpectedError');
      }
      return Right(response);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      return Left('Auth.unexpectedError');
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getDataWitheq(
      String table, String query, String eqKey, String eqValue) async {
    try {
      final response =
          await _supabase.from(table).select(query).eq(eqKey, eqValue);
      return Right(response);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      return Left('Auth.unexpectedError');
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getDataWitheqAndLimit(
      {required String table,
      required String query,
      required String eqKey,
      required String eqValue,
      int? limit}) async {
    try {
      final response = await _supabase
          .from(table)
          .select(query)
          .eq(eqKey, eqValue)
          .limit(limit ?? 9);
      return Right(response);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      return Left('Auth.unexpectedError');
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getDataWithTwoeq(
      String table,
      String query,
      String eqKey1,
      String eqValue1,
      String eqKey2,
      String eqValue2) async {
    try {
      final response = await _supabase
          .from(table)
          .select(query)
          .eq(eqKey1, eqValue1)
          .eq(eqKey2, eqValue2);
      return Right(response);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      return Left('Auth.unexpectedError');
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getDataWithTwoeqQuery(
      String table,
      String query,
      String eqKey1,
      String eqValue1,
      String eqKey2,
      String eqValue2) async {
    try {
      final response = _supabase.from(table).select(query);
      final filteredResponse = response.eq(eqKey1, eqValue1);
      final filteredResponse2 = await filteredResponse.eq(eqKey2, eqValue2);

      return Right(filteredResponse2);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      return Left('Auth.unexpectedError');
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getDataWithThreeeq(
      {required String table,
      required String query,
      required String eqKey1,
      required String eqValue1,
      required String eqKey2,
      required String eqValue2,
      required String eqKey3,
      required String eqValue3}) async {
    try {
      final response = await _supabase
          .from(table)
          .select(query)
          .eq(eqKey1, eqValue1)
          .eq(eqKey2, eqValue2)
          .eq(eqKey3, eqValue3);
      return Right(response);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      return Left('Auth.unexpectedError');
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getDataWithFilters(
      String table, String query,
      {String? specialty,
      String? government,
      bool? highestFee,
      String? city,
      int? rate,
      String? doctorFirstName,
      String? doctorLastName,
      bool? ar}) async {
    try {
      print(ar);
      print(doctorFirstName);
      var queryBuilder = _supabase.from(table).select(query);

      if (specialty != null) {
        queryBuilder = queryBuilder.eq('Doctors.specialty', specialty);
      }
      if (government != null) {
        queryBuilder = queryBuilder.eq('government', government);
      }
      if (city != null) {
        queryBuilder = queryBuilder.eq('city', city);
      }
      if (doctorFirstName != null) {
        queryBuilder = queryBuilder.ilike(
          ar ?? false ? 'Doctors.first_name_ar' : 'Doctors.first_name',
          '%$doctorFirstName%',
        );
      }
      if (doctorLastName != null) {
        queryBuilder =
            queryBuilder.ilike('Doctors.last_name', '%$doctorLastName%');
      }
      if (highestFee != null) {
        if (highestFee) {
          queryBuilder.order('fee', ascending: true);
        } else {
          queryBuilder.order('fee', ascending: false);
        }
      }
      if (rate != null) {
        queryBuilder.gte('rate', rate);
      }

      final response =
          await queryBuilder.range(0, 5).order('rate', ascending: true);
      return Right(response);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      return Left('Auth.unexpectedError');
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getDataWithLabFilters(
      {required String table,
      required String query,
      String? specialty,
      String? government,
      String? city,
      int? rate,
      String? name,
      bool? ar}) async {
    try {
      var queryBuilder = _supabase.from(table).select(query);

      if (specialty != null) {
        queryBuilder = queryBuilder.eq('Laboratories.specialty', specialty);
      }
      if (government != null) {
        queryBuilder = queryBuilder.eq('government', government);
      }
      if (city != null) {
        queryBuilder = queryBuilder.eq('city', city);
      }
      if (name != null) {
        queryBuilder = queryBuilder.ilike(
          ar ?? false ? 'Laboratories.name_ar' : 'Laboratories.name',
          '%$name%',
        );
      }

      if (rate != null) {
        queryBuilder.gte('rate', rate);
      }

      final response =
          await queryBuilder.range(0, 5).order('rate', ascending: true);
      return Right(response);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      return Left('Auth.unexpectedError');
    }
  }

  Future<Either<String, Map<String, dynamic>>> setData(
      {required String table, required Map<String, dynamic> data}) async {
    try {
      final response =
          await _supabase.from(table).insert(data).select().single();
      return Right(response);
    } on PostgrestException catch (e) {
      log(e.toString());
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      print(e);
      log(e.toString());
      return Left('Auth.unexpectedError');
    }
  }

  Future<Either<String, void>> deleteData(String table, String id) async {
    try {
      await _supabase.from(table).delete().eq('id', id);
      return Right(null);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      return Left('Auth.unexpectedError');
    }
  }

  Future<Either<String, String>> updateDataWitheq(
      {required String table,
      required String eqKey,
      required String eqValue,
      required Map<String, dynamic> data}) async {
    try {
      await _supabase.from(table).update(data).eq(eqKey, eqValue);
      return Right(eqValue);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      log(e.toString());
      return Left('Auth.unexpectedError');
    }
  }

  String _handleDatabaseError(PostgrestException e) {
    if (e.code == '23505') {
      return 'Auth.userExists';
    } else if (e.code == '23503') {
      return 'Auth.formatError';
    } else if (e.code == '22001') {
      return 'Auth.dataTooLong';
    } else {
      log(e.toString());
      return 'Auth.unexpectedError';
    }
  }

  Future<Either<String, String>> uploadImage({required File file}) async {
    try {
      final fileName =
          'Images/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

      final response =
          await _supabase.storage.from('Images').upload(fileName, file);
      return Right(response);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> getPublicUrl(
      {required String fileName}) async {
    try {
      final response = _supabase.storage.from('Images').getPublicUrl(fileName);
      return Right(response);
    } catch (e) {
      return Left("Image url not found");
    }
  }

  Future<Either<String, int>> count() async {
    try {
      final String userId = await Storage.readValue(key: 'id') ?? '';
      final response = await _supabase
          .from('Notifications')
          .count(CountOption.exact)
          .eq('read', false)
          .eq('patient_id', userId);

      return Right(response);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      log(e.toString());
      return Left('Auth.unexpectedError');
    }
  }
}
