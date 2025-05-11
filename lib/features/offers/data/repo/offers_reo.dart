import 'package:dartz/dartz.dart';

abstract class OffersReo {
  Future<Either<String, List<Map<String, dynamic>>>> getOffers(
      {required String provider});
  Future<Either<String, List<Map<String, dynamic>>>> getOffersWithLimit(
      {required String provider});
}
