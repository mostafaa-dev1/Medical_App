import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/home/data/repo/home_repo.dart';

class HomeData extends HomeRepository {
  final _supabaseServices = SupabaseServices();
  @override
  Future<Either<String, List<Map<String, dynamic>>>> getHomeData() {
    // TODO: implement getHomeData
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getNearByDoctors() {
    return _supabaseServices.getDataWithLimit('Doctors', '*,Clinics(*)');
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getSpecialitiesData(
      {required String type, int? limit}) {
    return _supabaseServices.getDataWitheqAndLimit(
        table: 'Specialties',
        query: '*',
        eqKey: 'type',
        eqValue: type,
        limit: limit);
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getUpcomingVisits(
      {required String patientId}) async {
    final response = await _supabaseServices.getDataWithTwoeq('Appointments',
        '*,Doctors(*),Clinics(*)', 'patient_id', patientId, 'type', 'Upcoming');

    return response;
  }
}
