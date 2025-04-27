import 'package:dartz/dartz.dart';

abstract class BookAppointmentRepo {
  Future<Either<String, List<Map<String, dynamic>>>> getAppointmentTimes(
      {required String doctorId, required String date});
}
