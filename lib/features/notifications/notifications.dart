import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPreferances.padding),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.lightRed.withAlpha(20),
                        ),
                        child: Icon(
                          Icons.close,
                          color: AppColors.lightRed,
                          size: 25,
                        ),
                      ),
                      horizontalSpace(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment Canceled!',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          verticalSpace(5),
                          Text(
                            '19 Dec 2022 | 10:00 AM',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
            verticalSpace(10),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondaryColor.withAlpha(20),
                        ),
                        child: Icon(
                          IconBroken.Calendar,
                          color: AppColors.secondaryColor,
                          size: 25,
                        ),
                      ),
                      horizontalSpace(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment Scheduled!',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          verticalSpace(5),
                          Text(
                            '19 Dec 2022 | 10:00 AM',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
            verticalSpace(10),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.lightGreen.withAlpha(20),
                        ),
                        child: Icon(
                          IconBroken.Calendar,
                          color: AppColors.lightGreen,
                          size: 25,
                        ),
                      ),
                      horizontalSpace(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment Booked!',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          verticalSpace(5),
                          Text(
                            '19 Dec 2022 | 10:00 AM',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
            verticalSpace(10),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.lightGreen.withAlpha(20),
                        ),
                        child: Icon(
                          Icons.check,
                          color: AppColors.lightGreen,
                          size: 25,
                        ),
                      ),
                      horizontalSpace(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment Confirmed',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          verticalSpace(5),
                          Text(
                            '19 Dec 2022 | 10:00 AM',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            verticalSpace(10),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondaryColor.withAlpha(20),
                        ),
                        child: Icon(
                          IconBroken.Wallet,
                          color: AppColors.secondaryColor,
                          size: 25,
                        ),
                      ),
                      horizontalSpace(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Success',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          verticalSpace(5),
                          Text(
                            '19 Dec 2022 | 10:00 AM',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
