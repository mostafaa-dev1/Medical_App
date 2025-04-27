import 'package:dartz/dartz.dart';

abstract class SpecilaltiesRepo {
  Future<Either<String, List<Map<String, dynamic>>>> getSpecialities({
    required String type,
  });
}
