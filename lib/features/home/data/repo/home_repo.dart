import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<String, List<Map<String, dynamic>>>> getSpecialitiesData({
    required String type,
  });
  Future<Either<String, List<Map<String, dynamic>>>> getUpcomingVisits(
      {required String patientId});
  Future<Either<String, List<Map<String, dynamic>>>> getNearByDoctors();
  Future<Either<String, List<Map<String, dynamic>>>> getClinics();

  Future<Either<String, List<Map<String, dynamic>>>> getHomeData();
}
