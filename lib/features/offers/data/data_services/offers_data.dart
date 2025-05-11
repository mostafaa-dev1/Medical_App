import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/offers/data/repo/offers_reo.dart';

class OffersData extends OffersReo {
  final _supabaseServices = SupabaseServices();
  @override
  Future<Either<String, List<Map<String, dynamic>>>> getOffers(
      {required String provider}) {
    String query = provider == 'Doctor'
        ? '*,Clinics(*,Doctors(*))'
        : provider == 'Lab'
            ? '*,LaboratoriesInfo(*,Laboratories(*))'
            : '*,HospitalsInfo(*,Hospitals(*)),Doctors(*)';

    return _supabaseServices.getDataWitheq(
        'Offers', query, 'provider', provider);
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getOffersWithLimit(
      {required String provider}) {
    String query = provider == 'Doctor'
        ? '*,Clinics(*,Doctors(*))'
        : provider == 'Lab'
            ? '*,LaboratoriesInfo(*,Laboratories(*))'
            : '*,HospitalsInfo(*,Hospitals(*)),Doctors(*)';
    return _supabaseServices.getDataWitheqAndLimit(
        table: 'Offers',
        query: query,
        eqKey: 'provider',
        eqValue: provider,
        limit: 5);
  }
}
