import 'package:dartz/dartz.dart';

abstract class NotificationsRepo {
  Future<Either<String, List<Map<String, dynamic>>>> getNotifications({
    required String patientId,
  });
  Future<Either<String, String>> readNotification({required String id});
}
