import 'package:dartz/dartz.dart';

abstract class BookAppointmentRepo {
  Future<Either<String, List<Map<String, dynamic>>>> getAppointmentTimes(
      {required String eqvalue, required String eqkey, required String date});
}
