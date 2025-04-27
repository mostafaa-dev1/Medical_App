import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/home/ui/widgets/home_header_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UpcomingItemLoading extends StatelessWidget {
  const UpcomingItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          HomeHeaderItem(
            onPress: () {},
            title: 'home.upcomingVisits',
          ),
          verticalSpace(10),
          SizedBox(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: LanguageChecker.isArabic(context) ? 0 : 10,
                              right:
                                  LanguageChecker.isArabic(context) ? 10 : 0),
                          width: 300,
                          height: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.shadow,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                )
                              ],
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).colorScheme.primary),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  textDirection: ui.TextDirection.ltr,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                        radius: 20,
                                        backgroundImage: AssetImage(
                                            'assets/images/doctor.png')),
                                    horizontalSpace(10),
                                    Column(
                                      textDirection: ui.TextDirection.ltr,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Name',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!),
                                        Text('Speciality',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.more_vert,
                                        color: index % 2 == 0
                                            ? Colors.white
                                            : Theme.of(context).canvasColor,
                                        size: 20),
                                  ]),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    IconBroken.Time_Circle,
                                    size: 15,
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : Theme.of(context).canvasColor,
                                  ),
                                  horizontalSpace(5),
                                  Text(
                                    'Time',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            color: index % 2 == 0
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .canvasColor),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      'Status',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              color: AppColors.secondaryColor,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ));
                  })),
        ],
      ),
    );
  }
}
