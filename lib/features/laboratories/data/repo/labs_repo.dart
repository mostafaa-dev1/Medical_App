import 'package:dartz/dartz.dart';

abstract class LabsRepo {
  Future<Either<String, List<Map<String, dynamic>>>> getLabs({
    required String specialty,
  });
}
