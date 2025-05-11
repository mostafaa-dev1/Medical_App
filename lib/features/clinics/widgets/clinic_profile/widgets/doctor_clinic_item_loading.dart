import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DoctorClinicItemLoading extends StatelessWidget {
  const DoctorClinicItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Skeletonizer(
        enabled: true,
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow,
                        spreadRadius: 3,
                        blurRadius: 5,
                      )
                    ]),
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/user.png',
                                height: 60,
                                width: 60,
                              )),
                          horizontalSpace(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              verticalSpace(5),
                              Text(
                                'Speciality',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.mainColor,
                                size: 15,
                              ),
                              horizontalSpace(5),
                              Text(
                                '0.0 (0)',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              horizontalSpace(5),
                            ],
                          )
                        ]),
                    Row(
                      children: [
                        Text(
                          'Not Available',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Spacer(),
                        CustomButton(
                            buttonName: 'appointments.bookNow',
                            onPressed: () {},
                            height: 30,
                            width: 100,
                            paddingVirtical: 0,
                            paddingHorizental: 10)
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
