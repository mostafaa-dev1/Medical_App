import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class AiSearchItem extends StatelessWidget {
  const AiSearchItem({super.key, required this.clinics, required this.user});
  final Clinics clinics;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: clinics.clinics!.length,
        itemBuilder: (context, index) {
          final clinic = clinics.clinics![index];
          return Container(
              width: 330,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: clinic.doctor!.image != null
                              ? NetworkImage(clinic.doctor!.image!)
                              : AssetImage('assets/images/user.png'),
                        ),
                        horizontalSpace(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${'appointments.dr'.tr()} ${LanguageChecker.isArabic(context) ? clinic.doctor!.firstNameAr : clinic.doctor!.firstName} ${LanguageChecker.isArabic(context) ? clinic.doctor!.lastNameAr : clinic.doctor!.lastName}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            verticalSpace(2),
                            Text(
                                'specialities.${clinic.doctor!.specialty}'.tr(),
                                style: Theme.of(context).textTheme.labelMedium)
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.mainColor,
                              size: 20,
                            ),
                            horizontalSpace(2),
                            Text(
                                '${Format.formatNumber(clinic.rate, context)} (${Format.formatNumber(clinic.rateCount, context)})',
                                style: Theme.of(context).textTheme.bodySmall!),
                          ],
                        ),
                      ],
                    ),
                    verticalSpace(5),
                    Row(
                      children: [
                        Icon(
                          IconBroken.Location,
                          color: AppColors.mainColor,
                          size: 18,
                        ),
                        horizontalSpace(5),
                        Text(
                          '${'government.${clinic.government}'.tr()}, ${'city.${clinic.city}'},${LanguageChecker.isArabic(context) ? clinic.address!.streatAr : clinic.address!.streat}',
                          style: Theme.of(context).textTheme.labelMedium!,
                        )
                      ],
                    ),
                    verticalSpace(5),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.secondaryColor.withAlpha(15),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.attach_money_outlined,
                                color: AppColors.mainColor,
                                size: 20,
                              ),
                              horizontalSpace(5),
                              Text(
                                  '${Format.formatNumber(200, context)} ${'search.patient'.tr()}',
                                  style:
                                      Theme.of(context).textTheme.labelSmall!),
                            ],
                          ),
                        ),
                        horizontalSpace(5),
                        clinic.services!.contains('Elevator')
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.secondaryColor.withAlpha(15),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.elevator_rounded,
                                      color: AppColors.mainColor,
                                      size: 20,
                                    ),
                                    horizontalSpace(5),
                                    Text('search.elevator'.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!)
                                  ],
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    verticalSpace(5),
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: Format.formatPrice(clinic.fee, context),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            children: [
                              TextSpan(
                                text: ' ${'search.appPrice'.tr()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: AppColors.lightBlue),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        CustomButton(
                          buttonName: 'appointments.bookNow'.tr(),
                          onPressed: () {
                            context.pushNamed(AppRoutes.doctorProfile,
                                arguments: {
                                  'user': user,
                                  'clinic': clinic,
                                  'doctorId': clinic.doctor!.id
                                });
                          },
                          width: Responsive.appWidth(context) > 600 ? 100 : 80,
                          paddingVirtical: 0,
                          fontSize: 12,
                          height: 25,
                          paddingHorizental: 0,
                        ),
                      ],
                    )
                  ]));
        },
      ),
    );
  }
}
