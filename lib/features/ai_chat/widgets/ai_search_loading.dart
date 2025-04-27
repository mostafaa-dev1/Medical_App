import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AiSearchLoading extends StatelessWidget {
  const AiSearchLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Skeletonizer(
        enabled: true,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index2) {
            return Container(
                width: 320,
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
                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                          ),
                          horizontalSpace(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr.name',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              verticalSpace(2),
                              Text('Speciality',
                                  style:
                                      Theme.of(context).textTheme.labelMedium)
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
                              Text('0.0 (0)',
                                  style:
                                      Theme.of(context).textTheme.bodySmall!),
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
                            'location',
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
                                Text('0',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!),
                              ],
                            ),
                          ),
                          horizontalSpace(5),
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
                                  Icons.elevator_rounded,
                                  color: AppColors.mainColor,
                                  size: 20,
                                ),
                                horizontalSpace(5),
                                Text('search.elevator',
                                    style:
                                        Theme.of(context).textTheme.labelSmall!)
                              ],
                            ),
                          )
                        ],
                      ),
                      verticalSpace(5),
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            size: 15,
                          ),
                          Text.rich(
                            TextSpan(
                              text: '0',
                              style: Theme.of(context).textTheme.labelMedium!,
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
                            onPressed: () {},
                            width:
                                Responsive.appWidth(context) > 600 ? 100 : 80,
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
      ),
    );
  }
}
