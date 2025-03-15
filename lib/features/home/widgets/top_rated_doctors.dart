import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';

class TopRatedDoctors extends StatelessWidget {
  const TopRatedDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                'home.topRatedDoctors'.tr(),
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
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoutes.doctorProfile);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: LanguageChecker.isArabic(context) ? 0 : 60,
                          right: LanguageChecker.isArabic(context)
                              ? index == 0
                                  ? 10
                                  : 60
                              : 0),
                      padding: const EdgeInsets.only(left: 60, right: 10),
                      width: Responsive.isTablet(context)
                          ? Responsive.appWidth(context) / 2.2
                          : Responsive.appWidth(context) / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(
                          color: AppColors.mainColor,
                        ),
                      ),
                      child: Column(
                        textDirection: ui.TextDirection.ltr,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dr. John Doe',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Brain and Nerves doctor',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          verticalSpace(5),
                          Row(
                            textDirection: ui.TextDirection.ltr,
                            children: [
                              Row(
                                textDirection: ui.TextDirection.ltr,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.mainColor,
                                    size: 20,
                                  ),
                                  horizontalSpace(5),
                                  Text('4.5',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!),
                                  horizontalSpace(5),
                                  Text('(200)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.bookmark,
                                color: AppColors.mainColor,
                              )
                            ],
                          ),
                          verticalSpace(10),
                          Container(
                            width: 100,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: Text('home.bookNow'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: -50,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: LanguageChecker.isArabic(context) ? 0 : 60,
                          right: LanguageChecker.isArabic(context) ? 10 : 0),
                      height: 110,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).colorScheme.primary,
                          border: Border.all(
                            color: AppColors.mainColor,
                          )),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image(
                            image: AssetImage('assets/images/doctor.png'),
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
// OpenContainer(
//                 openBuilder: (BuildContext context, VoidCallback _) {
//                   return DoctorProfile();
//                 },
//                 tappable: true,
//                 transitionType: ContainerTransitionType.fade,
//                 closedShape: const RoundedRectangleBorder(),
//                 closedElevation: 0.0,
//                 closedBuilder: (BuildContext _, VoidCallback openContainer) {
//                   return Stack(
//                     alignment: Alignment.center,
//                     clipBehavior: Clip.none,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(
//                             left: LanguageChecker.isArabic(context) ? 0 : 60,
//                             right: LanguageChecker.isArabic(context)
//                                 ? index == 0
//                                     ? 10
//                                     : 60
//                                 : 0),
//                         padding: const EdgeInsets.only(left: 60, right: 10),
//                         width: Responsive.isTablet(context)
//                             ? Responsive.appWidth(context) / 2.2
//                             : Responsive.appWidth(context) / 1.5,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(35),
//                           color: Theme.of(context).colorScheme.primary,
//                           border: Border.all(
//                             color: AppColors.mainColor,
//                           ),
//                         ),
//                         child: Column(
//                           textDirection: ui.TextDirection.ltr,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Dr. John Doe',
//                               style: Theme.of(context).textTheme.bodyLarge,
//                             ),
//                             Text(
//                               'Brain and Nerves doctor',
//                               style: Theme.of(context).textTheme.labelMedium,
//                             ),
//                             verticalSpace(5),
//                             Row(
//                               textDirection: ui.TextDirection.ltr,
//                               children: [
//                                 Row(
//                                   textDirection: ui.TextDirection.ltr,
//                                   children: [
//                                     Icon(
//                                       Icons.star,
//                                       color: AppColors.mainColor,
//                                       size: 20,
//                                     ),
//                                     horizontalSpace(5),
//                                     Text('4.5',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodySmall!),
//                                     horizontalSpace(5),
//                                     Text('(200)',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodySmall!),
//                                   ],
//                                 ),
//                                 Spacer(),
//                                 Icon(
//                                   Icons.bookmark,
//                                   color: AppColors.mainColor,
//                                 )
//                               ],
//                             ),
//                             verticalSpace(10),
//                             Container(
//                               width: 100,
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 3),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: AppColors.mainColor,
//                               ),
//                               child: Center(
//                                 child: Text('home.bookNow'.tr(),
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodySmall!
//                                         .copyWith(color: Colors.white)),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Positioned(
//                         left: -50,
//                         child: Container(
//                           margin: EdgeInsets.only(
//                               left: LanguageChecker.isArabic(context) ? 0 : 60,
//                               right:
//                                   LanguageChecker.isArabic(context) ? 10 : 0),
//                           height: 110,
//                           width: 100,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               color: Theme.of(context).colorScheme.primary,
//                               border: Border.all(
//                                 color: AppColors.mainColor,
//                               )),
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(50),
//                               child: Image(
//                                 image: AssetImage('assets/images/doctor.png'),
//                                 fit: BoxFit.fill,
//                               )),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
