import 'package:bloc/bloc.dart';
import 'package:medical_system/features/notifications/data/model/notifications_model.dart';
import 'package:medical_system/features/notifications/data/services/notifications_data.dart';
import 'package:meta/meta.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  final _notificationsData = NotificationsData();

  List<NotificationModel>? notifications;
  Future<void> getNotifications({required String patientId}) async {
    emit(NotificationsLoading());
    final result =
        await _notificationsData.getNotifications(patientId: patientId);
    result.fold((l) {
      emit(NotificationsError(errMessage: l));
    }, (r) {
      notifications = r.map((e) => NotificationModel.fromJson(e)).toList();
      emit(NotificationsSuccess());
    });
  }

  Future<void> readNotification(
      {required String id, required int index}) async {
    emit(ReadNotificationLoading());
    final result = await _notificationsData.readNotification(id: id);
    result.fold((l) {
      emit(ReadNotificationError(errMessage: l));
    }, (r) {
      notifications![index].isRead = true;

      emit(ReadNotificationSuccess());
    });
  }
}
