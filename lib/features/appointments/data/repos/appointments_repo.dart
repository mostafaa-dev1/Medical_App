import 'package:dartz/dartz.dart';

abstract class AppointmentsRepo {
  Future<Either<String, List<Map<String, dynamic>>>> getAppointments(
      {required String patientId,
      required String eqKey2,
      required String eqValue2});
  Future<Either<String, String>> cancelAppointment(
      {required String id, required String reason});
  Future<Either<String, String>> rescheduleAppointment(
      {required String id,
      required String date,
      required String time,
      required String reason});
}
