import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/features/spcialities/widgets/spcialties_list.dart';

class Specialities extends StatelessWidget {
  const Specialities({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'specialities.specialities'.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPreferances.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'specialities.mostPopular'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalSpace(10),
            SpecialtiesList(user: user)
          ],
        ),
      ),
    );
  }
}
