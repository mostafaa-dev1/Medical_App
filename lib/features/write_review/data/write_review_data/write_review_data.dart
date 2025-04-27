import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/write_review/data/repo/write_review_repo.dart';

class WriteReviewData extends WriteReviewRepo {
  final _supabaseServices = SupabaseServices();
  @override
  Future<Either<String, List<Map<String, dynamic>>>> getClinicRate(
      {required String clinicId}) {
    return _supabaseServices.getDataWitheq('Clinics', '*', 'id', clinicId);
  }

  @override
  Future<Either<String, Map<String, dynamic>>> sendReview(
      {required String review,
      required double rate,
      required String userId,
      required String doctorId}) {
    return _supabaseServices.setData(table: 'Reviews', data: {
      'review': review,
      'rate': rate,
      'user_id': userId,
      'doctor_id': doctorId
    });
  }

  @override
  Future<Either<String, String>> sendClinicRate(
      {required String clinicId,
      required double rate,
      required int rateCount}) {
    return _supabaseServices.updateDataWitheq(
        table: 'Clinics',
        eqKey: 'id',
        eqValue: clinicId,
        data: {
          'rate': rate,
          'rate_count': rateCount,
        });
  }
}
