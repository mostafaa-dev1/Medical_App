import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/features/profile/widgets/profile_buttons.dart';
import 'package:medical_system/features/profile/widgets/profile_photo.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile.profile'.tr(),
            style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPreferances.padding),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ProfilePhoto(
              image: user.image,
            ),
            verticalSpace(20),
            Text(user.name, style: Theme.of(context).textTheme.titleSmall),
            verticalSpace(5),
            Text(user.phone, style: Theme.of(context).textTheme.labelLarge),
            verticalSpace(40),
            Divider(
              color: Theme.of(context).dividerColor,
              indent: AppPreferances.screenWidth(context) / 5.5,
              endIndent: AppPreferances.screenWidth(context) / 5.5,
            ),
            verticalSpace(40),
            ProfileButtons()
          ]),
        ),
      ),
    );
  }
}
