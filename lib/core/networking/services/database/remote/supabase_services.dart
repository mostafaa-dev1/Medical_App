import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  // Step 1: Create a private static instance
  static final SupabaseServices _instance = SupabaseServices._internal();

  // Step 2: Provide a factory constructor to return the same instance
  factory SupabaseServices() {
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
      final response = await _supabase.from(table).select(query).range(0, 9);
      if (response.isEmpty) {
        return Left('لا يوجد بيانات');
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
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> setData(
      String table, Map<String, dynamic> data) async {
    try {
      await _supabase.from(table).insert(data);
      return Right(null);
    } on PostgrestException catch (e) {
      return Left(_handleDatabaseError(e));
    } on SocketException {
      return Left('Auth.networkError');
    } on TimeoutException {
      return Left('Auth.networkError');
    } catch (e) {
      print(e);
      log(e.toString());
      return Left(e.toString());
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

  Future<Either<String, void>> updateDataWitheq(String table, String eqKey,
      String eqValue, Map<String, dynamic> data) async {
    try {
      await _supabase.from(table).update(data).eq(eqKey, eqValue);
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
}
