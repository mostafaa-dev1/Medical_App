import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OffersLoading extends StatelessWidget {
  const OffersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
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
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Brain and Nerves',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: AssetImage(
                                  'assets/images/doctor.png',
                                ),
                              ),
                              horizontalSpace(5),
                              Text(
                                'Dr. Mohamed Ali',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            '20%',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.red),
                          ),
                          Text.rich(TextSpan(
                            text: '500',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    decorationThickness: 3),
                            children: [
                              TextSpan(
                                  text: ' - 400',
                                  style: Theme.of(context).textTheme.bodySmall!)
                            ],
                          ))
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Row(
                    children: [
                      Icon(
                        IconBroken.Time_Circle,
                        size: 15,
                      ),
                      horizontalSpace(5),
                      Text(
                        '14 Feb - 30 Feb',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Spacer(),
                      CustomButton(
                          buttonName: 'home.bookNow',
                          onPressed: () {},
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
          }),
    );
  }
}
