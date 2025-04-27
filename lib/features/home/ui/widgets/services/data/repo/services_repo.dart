import 'package:dartz/dartz.dart';
import 'package:medical_system/features/home/ui/widgets/services/data/models/find_medicine.dart';
import 'package:medical_system/features/home/ui/widgets/services/data/models/question_model.dart';

abstract class ServicesRepo {
  Future<Either<String, void>> sendQuestion(
      {required QuestionModel questionModel});
  Future<Either<String, void>> findMedicine(
      {required FindMedicineModel findMedicine});
}
