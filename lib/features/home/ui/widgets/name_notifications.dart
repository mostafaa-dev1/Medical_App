import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/logic/app_cubit.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';

class NameNotifications extends StatelessWidget {
  NameNotifications({super.key, required this.user});
  final UserModel user;
  final date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoutes.profile, arguments: user);
          },
          child: CircleAvatar(
            radius: 20,
            backgroundImage: user.image != null && user.image != ''
                ? CachedNetworkImageProvider(user.image!)
                : const AssetImage(
                    'assets/images/user.png',
                  ),
          ),
        ),
        horizontalSpace(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date.hour > 12
                  ? '${'home.goodEvening'.tr()} 👋'
                  : '${'home.goodMorning'.tr()} 👋',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              '${user.firstName} ${user.lastName}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoutes.notifications, arguments: user.id);
          },
          child: context.read<AppCubit>().notificationsCount == 0
              ? const Icon(IconBroken.Notification, size: 25)
              : Badge(
                  backgroundColor: AppColors.lightRed,
                  label: Text(
                      context.read<AppCubit>().notificationsCount.toString()),
                  child: Icon(
                    IconBroken.Notification,
                    size: 25,
                  ),
                ),
        )
      ],
    );
  }
}
