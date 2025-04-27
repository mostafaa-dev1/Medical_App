import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/home/ui/widgets/offers/data/model/offers_model.dart';

class OfferItem extends StatelessWidget {
  const OfferItem({super.key, required this.offers});
  final OffersModel offers;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
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
                  width: 300,
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
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: offers.doctor!.image != null
                            ? NetworkImage(offers.doctor!.image!)
                                as ImageProvider
                            : AssetImage(
                                'assets/images/doctor.png',
                              ),
                      ),
                      horizontalSpace(5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${'appointments.dr'.tr()}${LanguageChecker.isArabic(context) ? offers.doctor!.firstNameAr : offers.doctor!.firstName} ${LanguageChecker.isArabic(context) ? offers.doctor!.lastNameAr : offers.doctor!.lastName}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            'specialities.${offers.doctor!.specialty}'.tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'home.bookNow'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
