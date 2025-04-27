import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/home/ui/widgets/services/data/models/find_medicine.dart';
import 'package:medical_system/features/home/ui/widgets/services/data/models/question_model.dart';
import 'package:medical_system/features/home/ui/widgets/services/data/repo/services_repo.dart';

class ServicesData extends ServicesRepo {
  final _suapabaseServices = SupabaseServices();
  @override
  Future<Either<String, void>> findMedicine(
      {required FindMedicineModel findMedicine}) {
    try {
      return _suapabaseServices.setData(
          table: 'FindMedicine', data: findMedicine.toJson());
    } catch (e) {
      return Future.value(Left(e.toString()));
    }
  }

  @override
  Future<Either<String, void>> sendQuestion(
      {required QuestionModel questionModel}) {
    try {
      return _suapabaseServices.setData(
          table: 'Questions', data: questionModel.toJson());
    } catch (e) {
      return Future.value(Left(e.toString()));
    }
  }
}
