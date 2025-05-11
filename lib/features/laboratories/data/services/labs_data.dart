import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/laboratories/data/repo/labs_repo.dart';

class LabsData extends LabsRepo {
  final _supabaseServices = SupabaseServices();
  @override
  Future<Either<String, List<Map<String, dynamic>>>> getLabs({
    required String specialty,
    String? rate,
    String? gov,
    String? city,
  }) {
    return _supabaseServices.getDataWithThreeeq(
      table: 'LaboratoriesInfo',
      query: '*,Laboratories!inner(*)',
      eqKey1: 'Laboratories.specialty',
      eqValue1: specialty,
      eqKey2: 'government',
      eqValue2: gov!,
      eqKey3: 'city',
      eqValue3: city!,
    );
  }
}
