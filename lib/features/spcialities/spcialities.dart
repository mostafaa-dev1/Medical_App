import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/constants/theme_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class Specialities extends StatelessWidget {
  Specialities({super.key});
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Specialities',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPreferances.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Most Popular Specialities',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalSpace(10),
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount:
                      MediaQuery.sizeOf(context).width > 600 ? 3 : 2,
                  childAspectRatio:
                      MediaQuery.sizeOf(context).width > 600 ? 2.6 : 2.3,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    width: 200,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
