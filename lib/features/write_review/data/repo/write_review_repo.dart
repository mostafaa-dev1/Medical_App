import 'package:dartz/dartz.dart';

abstract class WriteReviewRepo {
  Future<Either<String, List<Map<String, dynamic>>>> getClinicRate({
    required String clinicId,
  });
  Future<Either<String, Map<String, dynamic>>> sendReview(
      {required String review,
      required double rate,
      required String userId,
      required String doctorId});

  Future<Either<String, String>> sendClinicRate(
      {required String clinicId, required double rate, required int rateCount});
}
