import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/home/ui/widgets/home_header_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NearestDoctorsLoading extends StatelessWidget {
  const NearestDoctorsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: false,
      child: Column(
        children: [
          HomeHeaderItem(onPress: () {}, title: 'home.topRatedDoctors'),
          verticalSpace(10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  padding: const EdgeInsets.all(10),
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Theme.of(context).colorScheme.primary,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Theme.of(context).colorScheme.primary,
                            border: Border.all(
                              color: AppColors.mainColor,
                            )),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image(
                              image: AssetImage('assets/images/doctor.png'),
                              fit: BoxFit.fill,
                            )),
                      ),
                      horizontalSpace(10),
                      Column(
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
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        AppColors.secondaryColor.withAlpha(15)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      color: AppColors.mainColor,
                                      size: 20,
                                    ),
                                    horizontalSpace(5),
                                    Text('200 EGP',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!),
                                  ],
                                ),
                              ),
                              horizontalSpace(5),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        AppColors.secondaryColor.withAlpha(15)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: AppColors.mainColor,
                                      size: 20,
                                    ),
                                    horizontalSpace(5),
                                    Text('4.5 (200)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(10),
                          Container(
                            width: 100,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: Text('bookNow',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
