import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/offers/data/model/offers_model.dart';
import 'package:medical_system/features/offers/ui/widgets/offer_item.dart';

class OffersProfile extends StatelessWidget {
  const OffersProfile({super.key, required this.offer, required this.user});
  final OffersModel offer;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        CustomButton(
          buttonName: 'home.bookNow'.tr(),
          onPressed: () {
            Appointment appointment;
            WorkTimes workTimes;
            if (offer.provider == 'Doctor') {
              appointment = Appointment(
                  clinic: offer.clinic,
                  clinicId: offer.clinic!.id,
                  fee: offer.price,
                  type: 'Upcoming');
              workTimes = offer.clinic!.workTimes!;
            } else if (offer.provider == 'Clinic') {
              appointment = Appointment(
                  hospital: offer.hospital,
                  hospitalId: offer.hospital!.id,
                  fee: offer.price,
                  type: 'Upcoming');
              workTimes = offer.doctor!.workTimes!;
            } else {
              appointment = Appointment(
                lab: offer.lab,
                labId: offer.lab!.id,
                fee: offer.price,
                type: 'Upcoming',
              );
              workTimes = offer.lab!.workTimes!;
            }

            context.pushNamed(AppRoutes.pickAppointmentDate, arguments: {
              'user': user,
              'appointment': appointment,
              'workTimes': workTimes,
              'reason': '',
              'reschdule': false,
              'doctorId': '',
              'appointmentId': ''
            });
          },
          width: double.infinity,
          paddingVirtical: 0,
          paddingHorizental: 10,
          height: 40,
        )
      ],
      appBar: AppBar(
        title: Text(
          'home.offers'.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPreferances.padding),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: offer.images![0],
                    height: MediaQuery.sizeOf(context).width > 700 ? 300 : 175,
                    width: double.infinity,
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
                      '${offer.discountPercentage.toString()}%',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    offer.provider == 'Doctor'
                        ? clinicInfo(offer, context)
                        : offer.provider == 'Lab'
                            ? labInfo(offer, context)
                            : hospitalInfo(offer, context),
                  ],
                ),
                Spacer(),
                Text.rich(TextSpan(
                  text: '${offer.originalPrice}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.lightRed,
                      decorationThickness: 3),
                  children: [
                    TextSpan(
                        text: ' - ${offer.price}',
                        style: Theme.of(context).textTheme.bodySmall!)
                  ],
                )),
              ],
            ),
            verticalSpace(10),
            Divider(
              color: Theme.of(context).dividerColor,
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
                      '${DateFormat('d MMM', LanguageChecker.isArabic(context) ? 'ar' : 'en').format(offer.startDate!)} - ${DateFormat('d MMM', LanguageChecker.isArabic(context) ? 'ar' : 'en').format(offer.endDate!)}',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '${offer.usageLimit == 0 ? 'home.unlimited'.tr() : offer.usageLimit.toString()} ${'home.remainingRedmeas'.tr()}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
            verticalSpace(10),
            Divider(
              color: Theme.of(context).dividerColor,
            ),
            verticalSpace(10),
            Text(
              LanguageChecker.isArabic(context)
                  ? offer.descriptionAr
                  : offer.description,
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
      ),
    );
  }
}
