import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/constants/theme_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class DoctorSpciality extends StatelessWidget {
  DoctorSpciality({super.key});
  final List<String> categories = ['brain', 'liver', 'heart', 'nose', 'lang'];

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
                onTap: () {},
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
          height: 80,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                    width: 80,
                    padding: const EdgeInsets.all(5),
                    margin: EdgeInsets.only(
                        left: LanguageChecker.isArabic(context) ? 0 : 10,
                        right: LanguageChecker.isArabic(context) ? 10 : 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mainColor),
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/categories/${categories[index]}.svg',
                          colorFilter: ColorFilter.mode(
                              AppColors.mainColor, BlendMode.srcIn),
                        ),
                        verticalSpace(5),
                        Text(
                          categories[index],
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
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
