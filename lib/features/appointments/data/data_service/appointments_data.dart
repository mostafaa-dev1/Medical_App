import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/appointments/data/repos/appointments_repo.dart';

class AppointmentsData extends AppointmentsRepo {
  final _supabaseServices = SupabaseServices();

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getAppointments(
      {required String patientId,
      required String eqKey2,
      required String eqValue2}) async {
    {
      return _supabaseServices.getDataWithTwoeq(
          'Appointments',
          '*,Clinics(*,Doctors(*)),HospitalsInfo(*,Hospitals(*)),Doctors(*),LaboratoriesInfo(*,Laboratories(*))',
          'patient_id',
          patientId,
          eqKey2,
          eqValue2);
    }
  }

  @override
  Future<Either<String, String>> cancelAppointment(
      {required String id, required String reason}) {
    return _supabaseServices.updateDataWitheq(
        table: 'Appointments',
        eqKey: 'id',
        eqValue: id,
        data: {
          'type': 'Cancelled',
          'problem_reason': reason,
          'status': 'Cancelled'
        });
  }

  @override
  Future<Either<String, String>> rescheduleAppointment(
      {required String id,
      required String date,
      required String time,
      required String reason}) {
    return _supabaseServices.updateDataWitheq(
        table: 'Appointments',
        eqKey: 'id',
        eqValue: id,
        data: {
          'date': date,
          'time': time,
          'problem_reason': reason,
        });
  }

  Future<Either<String, List<Map<String, dynamic>>>> getGetAppointment(
      {required int id}) {
    return _supabaseServices.getDataWitheq(
        'Appointments',
        '*,Clinics(*,Doctors(*)),HospitalsInfo(*,Hospitals(*)),Doctors(*),LaboratoriesInfo(*,Laboratories(*))',
        'id',
        id.toString());
  }
}
