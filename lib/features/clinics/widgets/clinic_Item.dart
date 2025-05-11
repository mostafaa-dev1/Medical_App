import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/clinics/data/model/clinic_model.dart';

class ClinicItem extends StatelessWidget {
  const ClinicItem({super.key, required this.clinic, required this.user});
  final ClinicInfo clinic;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.clinicsProfile,
            arguments: {'clinic': clinic, 'context': context, 'user': user});
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              spreadRadius: 3,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: clinic.clinic!.image,
                    fit: BoxFit.fill,
                    height: 90,
                    width: 90,
                  ),
                ),
                horizontalSpace(10),
                Expanded(
                  // <-- Wrap Column with Expanded
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            LanguageChecker.isArabic(context)
                                ? clinic.clinic!.nameAr
                                : clinic.clinic!.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.mainColor,
                                size: 15,
                              ),
                              horizontalSpace(5),
                              Text(
                                Format.formatNumber(clinic.rate ?? 0, context),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              horizontalSpace(5),
                              Text(
                                '(${Format.formatNumber(clinic.rateCount ?? 0, context)})',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      verticalSpace(5),
                      Row(
                        children: [
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 8, vertical: 4), // Add padding
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10),
                          //     color: AppColors.mainColor.withAlpha(20),
                          //   ),
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize
                          //         .min, // Important to prevent taking full width
                          //     children: [
                          //       Icon(Icons.home, size: 16), // reduce size a little
                          //       horizontalSpace(5),
                          //       Text(
                          //         Format.formatNumber(lab.patients ?? 0, context),
                          //         style: Theme.of(context).textTheme.bodySmall,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          clinic.services.contains("Elevator")
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4), // Add padding
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.mainColor.withAlpha(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // Important to prevent taking full width
                                    children: [
                                      Icon(Icons.elevator,
                                          size: 16,
                                          color: AppColors
                                              .mainColor), // reduce size a little
                                      horizontalSpace(5),
                                      Text(
                                        'search.elevator'.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                      verticalSpace(5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.mainColor,
                            size: 15,
                          ),
                          horizontalSpace(5),
                          Expanded(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              '${'government.${clinic.government}'.tr()}, ${'city.${clinic.city}'.tr()}, ${LanguageChecker.isArabic(context) ? clinic.address.streatAr : clinic.address.streat}, ${LanguageChecker.isArabic(context) ? clinic.address.buildingAr : clinic.address.building}',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            // verticalSpace(10),
            // Row(
            //   children: [
            //     // Icon(
            //     //   Icons.access_time,
            //     //   color: AppColors.mainColor,
            //     //   size: 15,
            //     // ),
            //     // horizontalSpace(5),
            //     // Text(
            //     //   calculateAvailability(lab.workTimes!)
            //     //       ? 'laboratories.available'.tr()
            //     //       : 'From ${lab.workTimes!.from} to ${lab.workTimes!.to}',
            //     //   style: Theme.of(context).textTheme.labelMedium,
            //     // ),
            //     Spacer(),
            //     CustomButton(
            //         buttonName: 'View',
            //         onPressed: () {},
            //         width: 100,
            //         height: 30,
            //         paddingVirtical: 0,
            //         paddingHorizental: 10)
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
