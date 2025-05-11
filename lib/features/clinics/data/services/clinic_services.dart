import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/clinics/data/repo/clinic_repo.dart';

class ClinicServices extends ClinicRepo {
  final _supabaseServices = SupabaseServices();
  @override
  Future<Either<String, List<Map<String, dynamic>>>> getClinics({
    String? gov,
    String? city,
  }) async {
    return await _supabaseServices.getDataWithTwoeq(
      'HospitalsInfo',
      '*,Hospitals(*)',
      'city',
      city!,
      'government',
      gov!,
    );
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getDcotors({
    required String specialty,
    required String hospitalId,
  }) async {
    return await _supabaseServices.getDataWithTwoeq(
        'HospitalsDoctors',
        '*,Doctors!inner(*)',
        'hos_id',
        hospitalId,
        'Doctors.specialty',
        specialty);
  }
}
