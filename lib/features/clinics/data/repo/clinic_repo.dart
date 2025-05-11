import 'package:dartz/dartz.dart';

abstract class ClinicRepo {
  Future<Either<String, List<Map<String, dynamic>>>> getClinics();
  Future<Either<String, List<Map<String, dynamic>>>> getDcotors({
    required String specialty,
    required String hospitalId,
  });
}
