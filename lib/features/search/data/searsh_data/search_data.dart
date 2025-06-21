import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/search/data/repo/search_repo.dart';

class SearchData extends SearchRepo {
  final _supabaseServices = SupabaseServices();
  @override
  Future<Either<String, List<Map<String, dynamic>>>> search({
    String? spciality,
    String? gov,
    String? rate,
    String? price,
    String? firstName,
    String? city,
    bool? ar,
  }) async {
    return _supabaseServices.getDataWithFilters(
      'Clinics',
      '*, Doctors!inner(*),DoctorsInfo(*)',
      specialty: spciality,
      government: gov,
      city: city,
      doctorFirstName: firstName,
    );
  }
}
