import 'package:dartz/dartz.dart';

abstract class DoctorProfileRepo {
  Future<Either<String, List<Map<String, dynamic>>>> getReviews(
      {required String doctorId});
}
