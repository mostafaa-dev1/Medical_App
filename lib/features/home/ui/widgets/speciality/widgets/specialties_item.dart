import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/constants/theme_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/home/data/models/spcilailties_model.dart';
import 'package:medical_system/features/main/logic/main_cubit.dart';

class SpecialtiesItem extends StatelessWidget {
  const SpecialtiesItem(
      {super.key,
      required this.specialities,
      required this.type,
      required this.index});
  final SpcilailtiesModel specialities;
  final String type;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type != 'Clinic') {
          context.pushNamed(AppRoutes.selectGovernment, arguments: {
            'specialty': specialities.specialty,
            'type': type,
            'user': context.read<MainCubit>().user
          });
        } else {
          context.pushNamed(AppRoutes.clinicsProfile, arguments: {
            'clinic': context.read<MainCubit>().clinics![index],
            'user': context.read<MainCubit>().user
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        width: 220,
        height: 80,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            specialities.image != null
                ? ClipRRect(
                    borderRadius:
                        BorderRadius.circular(type == 'Clinic' ? 10 : 0),
                    child: CachedNetworkImage(
                      imageUrl: specialities.image!,
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          'assets/images/placeholder.png',
                          width: 30,
                          height: 30,
                        );
                      },
                      color: type == 'Clinic'
                          ? null
                          : ThemeChecker.isDark(context)
                              ? Colors.white
                              : AppColors.mainColor,
                      height: type == 'Clinic' ? 50 : 30,
                      width: type == 'Clinic' ? 50 : 30,
                      fit: BoxFit.fill,
                      // color: ThemeChecker.isDark(context)
                      //     ? Colors.white
                      //     : AppColors.mainColor,
                    ),
                  )
                : Image.asset(
                    'assets/images/placeholder.png',
                    width: 30,
                    height: 30,
                  ),
            verticalSpace(10),
            Text(
              textAlign: TextAlign.center,
              type == 'Clinic'
                  ? LanguageChecker.isArabic(context)
                      ? specialities.specialtyAr!
                      : specialities.specialty!
                  : 'specialities.${specialities.specialty}'.tr(),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: ThemeChecker.isDark(context)
                        ? Colors.white
                        : AppColors.mainColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
