import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/spcialities/data/repo/specilalties_repo.dart';

class SpecilaltiesData extends SpecilaltiesRepo {
  final _supabaseServices = SupabaseServices();
  @override
  Future<Either<String, List<Map<String, dynamic>>>> getSpecialities({
    required String type,
  }) async {
    return await _supabaseServices.getDataWitheq(
        'Specialties', '*', 'type', type);
  }
}
