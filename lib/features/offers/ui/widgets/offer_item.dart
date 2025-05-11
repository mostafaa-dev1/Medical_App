import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/offers/data/model/offers_model.dart';

class OfferItem extends StatelessWidget {
  const OfferItem(
      {super.key,
      required this.offers,
      required this.isVertical,
      required this.user});
  final OffersModel offers;
  final bool isVertical;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isVertical ? double.infinity : 310,
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      margin: isVertical
          ? const EdgeInsets.only(
              bottom: 10,
              left: 10,
              right: 10,
            )
          : EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: LanguageChecker.isArabic(context) ? 0 : 10,
              right: LanguageChecker.isArabic(context) ? 10 : 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ]),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: offers.images![0],
                  height: 175,
                  width: isVertical ? double.infinity : 300,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    color: AppColors.lightRed,
                  ),
                  child: Text(
                    '${offers.discountPercentage.toString()}%',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(5),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  offers.provider == 'Doctor'
                      ? clinicInfo(offers, context)
                      : offers.provider == 'Lab'
                          ? labInfo(offers, context)
                          : hospitalInfo(offers, context),
                ],
              ),
              Spacer(),
              Text.rich(TextSpan(
                text: '${offers.originalPrice}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                    decorationThickness: 3),
                children: [
                  TextSpan(
                      text: ' - ${offers.price}',
                      style: Theme.of(context).textTheme.bodySmall!)
                ],
              )),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Icon(
                IconBroken.Time_Circle,
                size: 20,
              ),
              horizontalSpace(5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${DateFormat('d MMM', LanguageChecker.isArabic(context) ? 'ar' : 'en').format(offers.startDate!)} - ${DateFormat('d MMM', LanguageChecker.isArabic(context) ? 'ar' : 'en').format(offers.endDate!)}',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${offers.usageLimit == 0 ? 'home.unlimited'.tr() : offers.usageLimit.toString()} ${'home.remainingRedmeas'.tr()}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              Spacer(),
              CustomButton(
                  buttonName: 'home.viewDetails'.tr(),
                  onPressed: () {
                    context.pushNamed(AppRoutes.offersProfile, arguments: {
                      'offer': offers,
                      'user': user,
                      'context': context
                    });
                  },
                  height: 30,
                  fontSize: 12,
                  width: 80,
                  paddingVirtical: 0,
                  paddingHorizental: 5),
            ],
          )
        ],
      ),
    );
  }
}

Widget clinicInfo(OffersModel offers, BuildContext context) {
  return Row(
    children: [
      CircleAvatar(
        radius: 18,
        backgroundImage: offers.clinic!.doctor!.image != null
            ? NetworkImage(offers.clinic!.doctor!.image!) as ImageProvider
            : AssetImage(
                'assets/images/doctor.png',
              ),
      ),
      horizontalSpace(10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${'appointments.dr'.tr()}${LanguageChecker.isArabic(context) ? offers.clinic!.doctor!.firstNameAr : offers.clinic!.doctor!.firstName} ${LanguageChecker.isArabic(context) ? offers.clinic!.doctor!.lastNameAr : offers.clinic!.doctor!.lastName}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            'specialities.${offers.clinic!.doctor!.specialty}'.tr(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    ],
  );
}

Widget labInfo(OffersModel offers, BuildContext context) {
  return Row(
    children: [
      CircleAvatar(
        radius: 18,
        backgroundImage: offers.lab!.lab!.image != null
            ? NetworkImage(offers.lab!.lab!.image!) as ImageProvider
            : AssetImage(
                'assets/images/doctor.png',
              ),
      ),
      horizontalSpace(5),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${LanguageChecker.isArabic(context) ? offers.lab!.lab!.nameAr : offers.lab!.lab!.name}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            'specialities.${offers.lab!.lab!.specialty}'.tr(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    ],
  );
}

Widget hospitalInfo(OffersModel offers, BuildContext context) {
  return Row(
    children: [
      CircleAvatar(
        radius: 18,
        backgroundImage: offers.hospital!.clinic!.image != ''
            ? NetworkImage(offers.hospital!.clinic!.image) as ImageProvider
            : AssetImage(
                'assets/images/doctor.png',
              ),
      ),
      horizontalSpace(5),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageChecker.isArabic(context)
                ? offers.hospital!.clinic!.nameAr
                : offers.hospital!.clinic!.name,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            'appointments.clinic'.tr(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    ],
  );
}
