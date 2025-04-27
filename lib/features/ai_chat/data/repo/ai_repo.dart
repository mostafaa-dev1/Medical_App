import 'package:dartz/dartz.dart';

abstract class AiRepo {
  Future<Either<String, List<dynamic>>> sendMessage(
      List<Map<String, dynamic>> messages);
}
