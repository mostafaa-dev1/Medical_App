import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class FavouriteDoctors extends StatelessWidget {
  const FavouriteDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Doctors',
            style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPreferances.padding),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(35),
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
                          height: 100,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Theme.of(context).colorScheme.primary,
                              border: Border.all(
                                color: AppColors.mainColor,
                              )),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image(
                                image: AssetImage('assets/images/doctor.png'),
                                fit: BoxFit.fill,
                              )),
                        ),
                        horizontalSpace(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. John Doe',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            verticalSpace(5),
                            Text(
                              'Brain and Nerves doctor',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            verticalSpace(5),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppColors.mainColor,
                                ),
                                horizontalSpace(5),
                                Text(
                                  '4.5',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              color: AppColors.mainColor,
                            ))
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
