import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/doctor_profile/data/repo/doctor_profile_repo.dart';

class DoctorProfileData extends DoctorProfileRepo {
  final _supabaseServices = SupabaseServices();
  @override
  Future<Either<String, List<Map<String, dynamic>>>> getReviews(
      {required String doctorId, int? limit}) async {
    return _supabaseServices.getDataWitheqAndLimit(
        table: 'Reviews',
        query: '*,Users(*)',
        eqKey: 'doctor_id',
        eqValue: doctorId,
        limit: limit);
  }
}
