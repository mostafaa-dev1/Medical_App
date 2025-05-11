import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/logic/app_cubit.dart';
import 'package:medical_system/core/widgets/not_found.dart';
import 'package:medical_system/features/notifications/logic/notifications_cubit.dart';
import 'package:medical_system/features/notifications/ui/widgets/notification_loading.dart';
import 'package:medical_system/features/notifications/ui/widgets/notifications_item.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state is ReadNotificationSuccess) {
          context.read<AppCubit>().decrementNotificationsCount();
        }
      },
      builder: (context, state) {
        var cubit = context.read<NotificationsCubit>();
        final notifications = cubit.notifications;
        if (state is NotificationsLoading) {
          return NotificationLoading();
        } else {
          if (notifications == null || notifications.isEmpty) {
            return const Expanded(child: NotFound());
          } else {
            return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return NotificationsItem(
                    notification: notifications[index],
                    index: index,
                  );
                });
          }
        }
      },
    );
  }
}
