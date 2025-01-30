import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  static final supabase = Supabase.instance.client;

  static Future<Either<String, List<Map<String, dynamic>>>> getData(
      String table, String query) async {
    try {
      final response = await supabase.from(table).select(query);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, List<Map<String, dynamic>>>> getDataWithLimit(
      String table, String query) async {
    try {
      final response = await supabase.from(table).select(query).range(0, 9);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, List<Map<String, dynamic>>>> getDataWitheq(
      String table, String query, String eqKey, String eqValue) async {
    try {
      final response =
          await supabase.from(table).select(query).eq(eqKey, eqValue);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, List<Map<String, dynamic>>>> setData(
      String table, Map<String, dynamic> data) async {
    try {
      final response = await supabase.from(table).insert(data);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, void>> deleteData(
      String table, String id) async {
    try {
      await supabase.from(table).delete().eq('id', id);
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, void>> updateDataWitheq(String table,
      String eqKey, String eqValue, Map<String, dynamic> data) async {
    try {
      await supabase.from(table).update(data).eq(eqKey, eqValue);
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> uploadImage({required File file}) async {
    try {
      final fileName =
          'Images/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

      final response =
          await supabase.storage.from('Images').upload(fileName, file);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> getPublicUrl(
      {required String fileName}) async {
    try {
      final response = supabase.storage.from('Images').getPublicUrl(fileName);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
