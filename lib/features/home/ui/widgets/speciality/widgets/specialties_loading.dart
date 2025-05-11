import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/theme_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/home/ui/widgets/home_header_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SpecialtiesLoading extends StatelessWidget {
  SpecialtiesLoading({super.key});
  // final List<String> categories = [
  //   'brain',
  //   'liver',
  //   'heart',
  //   'nose',
  //   'lang',
  //   'heart',
  //   'nose',
  //   'lang',
  //   'brain',
  //   'liver',
  //   'heart',
  //   'nose',
  //   'lang',
  //   'brain',
  //   'liver',

  // ];
  final List<String> speciality = [
    'Neurologist',
    'Cardiologist',
    'Gynecologist',
    'Dentist',
    'Surgeon',
    'Gynecologist',
    'Dentist',
    'Surgeon',
    'Neurologist',
    'Cardiologist',
    'Gynecologist',
    'Dentist',
    'Surgeon',
    'Gynecologist',
    'Dentist',
    'Surgeon',
    'Neurologist',
  ];
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          HomeHeaderItem(onPress: () {}, title: 'home.doctorSpeciality'),
          verticalSpace(10),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Responsive.appWidth(context) > 600 &&
                      Responsive.appWidth(context) < 800
                  ? 8
                  : Responsive.appWidth(context) < 600
                      ? 6
                      : 12,
              itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(5),
                    width: 200,
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
                        Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            )),
                        verticalSpace(20),
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
                  ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.appWidth(context) > 600 &&
                        Responsive.appWidth(context) < 800
                    ? 5
                    : Responsive.appWidth(context) < 600
                        ? 3
                        : 6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio:
                    MediaQuery.sizeOf(context).width > 600 ? 1.2 : 1.2,
              )),
        ],
      ),
    );
  }
}
