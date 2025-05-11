import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/notifications/data/model/notifications_model.dart';
import 'package:medical_system/features/notifications/logic/notifications_cubit.dart';

class NotificationsItem extends StatelessWidget {
  NotificationsItem(
      {super.key, required this.notification, required this.index});
  final NotificationModel notification;
  final int index;
  final Map<String, dynamic> type = {
    'Cancelled': 'notifications.canceled'.tr(),
    'Scheduled': 'notifications.scheduled'.tr(),
    'Booked': 'notifications.booked'.tr(),
    'Confirmed': 'notifications.confirmed'.tr(),
    'Payment': 'notifications.payment'.tr(),
  };
  final Map<String, dynamic> icons = {
    'Cancelled': Icons.close,
    'Scheduled': Icons.schedule,
    'Booked': IconBroken.Calendar,
    'Confirmed': Icons.check,
    'Payment': IconBroken.Wallet,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          color: notification.isRead
              ? Theme.of(context).colorScheme.primary
              : AppColors.secondaryColor.withAlpha(10),
          border: Border.all(
            color: notification.isRead
                ? Theme.of(context).colorScheme.primary
                : AppColors.secondaryColor.withAlpha(20),
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notification.type == 'Cancelled'
                      ? AppColors.lightRed.withAlpha(20)
                      : notification.type == 'Scheduled' ||
                              notification.type == 'Payment'
                          ? AppColors.lightGreen.withAlpha(20)
                          : AppColors.secondaryColor.withAlpha(20),
                ),
                child: Icon(
                  icons[notification.type],
                  color: notification.type == 'Cancelled'
                      ? AppColors.lightRed
                      : notification.type == 'Scheduled' ||
                              notification.type == 'Payment'
                          ? AppColors.lightGreen
                          : AppColors.secondaryColor,
                  size: 25,
                ),
              ),
              horizontalSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type[notification.type]!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  verticalSpace(5),
                  Text(
                    '${calculateDateDifference(notification.date, context)} | ${Format.formatTime(notification.date, context)}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              Spacer(),
              notification.isRead
                  ? Container()
                  : CustomButton(
                      buttonName: 'notifications.markAsRead'.tr(),
                      icon: Icons.done,
                      buttonColor: AppColors.mainColor,
                      withBorderSide: true,
                      fontSize: 10,
                      height: 25,
                      borderRadius: 5,
                      onPressed: () {
                        context.read<NotificationsCubit>().readNotification(
                            id: notification.id.toString(), index: index);
                      },
                      paddingHorizental: 5,
                      paddingVirtical: 0,
                      width: 80,
                    )
            ],
          ),
          verticalSpace(10),
          Text(
            LanguageChecker.isArabic(context)
                ? notification.contentAr
                : notification.content,
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }

  String calculateDateDifference(DateTime date, BuildContext context) {
    final now = DateTime.now();
    DateTime appointDate = DateTime(date.year, date.month, date.day);
    DateTime nowDate = DateTime(now.year, now.month, now.day);
    if (appointDate == nowDate) {
      return 'appointments.Today'.tr();
    } else if (appointDate.difference(nowDate).inDays == 1) {
      return 'appointments.Tomorrow'.tr();
    } else {
      return DateFormat(
              'd MMM', context.locale.languageCode == 'en' ? 'en' : 'ar')
          .format(date);
    }
  }
}
