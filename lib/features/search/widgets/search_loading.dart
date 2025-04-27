import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchListLoading extends StatelessWidget {
  const SearchListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Skeletonizer(
        enabled: true,
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: 10, top: 10, bottom: 0),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow,
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).colorScheme.primary,
                              border: Border.all(
                                color: AppColors.mainColor,
                              )),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                image: AssetImage('assets/images/user.png'),
                                fit: BoxFit.fill,
                              )),
                        ),
                        horizontalSpace(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First,Last',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'speciality',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            verticalSpace(5),
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
                                style: Theme.of(context).textTheme.bodySmall!),
                          ],
                        ),
                      ],
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        Icon(
                          IconBroken.Location,
                          color: AppColors.mainColor,
                          size: 18,
                        ),
                        horizontalSpace(5),
                        Text(
                          'Government, City, Street',
                          style: Theme.of(context).textTheme.labelMedium!,
                        )
                      ],
                    ),
                    verticalSpace(10),
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
                                Icons.person,
                                color: AppColors.mainColor,
                                size: 20,
                              ),
                              horizontalSpace(5),
                              Text('000 Patients',
                                  style:
                                      Theme.of(context).textTheme.bodySmall!),
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
                                  style: Theme.of(context).textTheme.bodySmall!)
                            ],
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    // Text(
                    //   buildNearestAvailableTimeWidget(clinic.workTimes!.workTimes!, context),

                    //     // '${'search.available'.tr()} ${clinic.workTimes!.workTimes![0].day} at ${clinic.workTimes!.workTimes![0].start!.hour} : ${clinic.workTimes!.workTimes![0].start!.minute} - ${clinic.workTimes!.workTimes![0].end!.hour} : ${clinic.workTimes!.workTimes![0].end!.minute}',
                    //     style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    //           color: AppColors.mainColor,
                    //         )),
                    Text('available at day,time'),
                    verticalSpace(10),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money_rounded,
                          size: 22,
                        ),
                        Text.rich(
                          TextSpan(
                            text: '000',
                            style: Theme.of(context).textTheme.bodyLarge!,
                            children: [
                              TextSpan(
                                text: 'appPrice',
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
                          buttonName: 'bookNow',
                          onPressed: () {},
                          width: Responsive.appWidth(context) > 600 ? 200 : 100,
                          paddingVirtical: 0,
                          height: 35,
                          paddingHorizental: 10,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
