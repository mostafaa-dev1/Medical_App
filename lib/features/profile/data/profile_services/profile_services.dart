import 'package:dartz/dartz.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/profile/data/repo/profile_repo.dart';

class ProfileServices extends ProfileRepo {
  final _supabaseServices = SupabaseServices();
  @override
  Future<Either<String, void>> updatePersonalInfo({UserModel? user}) {
    return _supabaseServices.updateDataWitheq(
        table: 'Users', data: user!.toJson(), eqKey: 'id', eqValue: user.id!);
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getLapReults(
      {required UserModel user}) {
    return _supabaseServices.getDataWitheq('LapResults',
        '*,LaboratoriesInfo(*,Laboratories(*))', 'user_id', user.id!);
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getQuestionAnswers(
      {required UserModel user}) {
    return _supabaseServices.getDataWitheq(
        'Questions', '*,Doctors(*)', 'user_id', user.id!);
  }
}
