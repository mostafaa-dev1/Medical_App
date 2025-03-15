import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/constants/theme_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';

class DoctorSpciality extends StatelessWidget {
  DoctorSpciality({super.key});
  final List<String> categories = ['brain', 'liver', 'heart', 'nose', 'lang'];
  final List<String> speciality = [
    'Neurologist',
    'Cardiologist',
    'Gynecologist',
    'Dentist',
    'Surgeon'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text(
                'home.doctorSpeciality'.tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.spcialities);
                },
                child: Text(
                  'home.seeAll'.tr(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                ),
              )
            ],
          ),
        ),
        verticalSpace(10),
        SizedBox(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(5),
                    width: 200,
                    margin: EdgeInsets.only(
                      left: LanguageChecker.isArabic(context) ? 0 : 10,
                      right: LanguageChecker.isArabic(context) ? 10 : 0,
                      bottom: 10,
                      top: 10,
                    ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.secondaryColor.withAlpha(20),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/categories/${categories[index]}.svg',
                            colorFilter: ColorFilter.mode(
                              AppColors.mainColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        horizontalSpace(10),
                        Text(
                          speciality[index],
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ThemeChecker.isDark(context)
                                        ? Colors.white
                                        : AppColors.mainColor,
                                  ),
                        ),
                      ],
                    ),
                  )),
        )
      ],
    );
  }
}
