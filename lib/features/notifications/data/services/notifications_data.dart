import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/notifications/data/repo/notifications_repo.dart';

class NotificationsData extends NotificationsRepo {
  final _supabaseService = SupabaseServices();
  @override
  Future<Either<String, List<Map<String, dynamic>>>> getNotifications({
    required String patientId,
  }) {
    return _supabaseService.getDataWitheq(
        'Notifications', '*', 'patient_id', patientId);
  }

  @override
  Future<Either<String, String>> readNotification({required String id}) {
    return _supabaseService.updateDataWitheq(
        table: 'Notifications', eqKey: 'id', eqValue: id, data: {'read': true});
  }
}
