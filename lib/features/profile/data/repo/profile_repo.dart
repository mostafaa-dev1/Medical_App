import 'package:dartz/dartz.dart';
import 'package:medical_system/core/models/user.dart';

abstract class ProfileRepo {
  Future<Either<String, void>> updatePersonalInfo({
    UserModel? user,
  });
  Future<Either<String, List<Map<String, dynamic>>>> getQuestionAnswers({
    required UserModel user,
  });
  Future<Either<String, List<Map<String, dynamic>>>> getLapReults({
    required UserModel user,
  });

  // Future<void> updateProfileImage(String imagePath);

  // Future<void> updatePassword(String oldPassword, String newPassword);

  // Future<void> deleteAccount();
}
