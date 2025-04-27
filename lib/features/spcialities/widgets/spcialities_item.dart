import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/theme_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/home/data/models/spcilailties_model.dart';

class SpcialitiesItem extends StatelessWidget {
  const SpcialitiesItem(
      {super.key, required this.specialities, required this.user});
  final SpcilailtiesModel specialities;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.search, arguments: {
          'speciality': specialities.specialty,
          'user': user,
          'withSearch': false
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            specialities.image != null && specialities.image!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: specialities.image!,
                    height: 30,
                    width: 30,
                    color: ThemeChecker.isDark(context)
                        ? Colors.white
                        : AppColors.mainColor)
                : Image.asset(
                    'assets/images/placeholder.png',
                    height: 30,
                    width: 30,
                  ),
            verticalSpace(10),
            Text(
              'specialities.${specialities.specialty}'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: ThemeChecker.isDark(context)
                        ? Colors.white
                        : AppColors.mainColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
