import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/logic/app_cubit.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';

class UpcomingVisits extends StatelessWidget {
  const UpcomingVisits({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text('home.upcomingVisits'.tr(),
                  style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.read<AppCubit>().changePageIndex(1);
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
        SizedBox(
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.appointmentDetails);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: LanguageChecker.isArabic(context) ? 0 : 10,
                            right: LanguageChecker.isArabic(context) ? 10 : 0),
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
                          color: index % 2 != 0
                              ? Theme.of(context).colorScheme.primary
                              : AppColors.mainColor,
                        ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Dr. Mohamed Ali',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: index % 2 == 0
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .canvasColor,
                                              )),
                                      Text(
                                        'Cardiologist',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                color: index % 2 == 0
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .canvasColor),
                                      ),
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
                                  '05 Feb 2025, 10:00 PM',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color: index % 2 == 0
                                              ? Colors.white
                                              : Theme.of(context).canvasColor),
                                ),
                                Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    'Confirmeded',
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
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}
