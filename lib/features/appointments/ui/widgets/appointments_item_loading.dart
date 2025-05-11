import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/widgets/doctor_card_button.dart';
import 'package:medical_system/core/widgets/doctor_card_oulined_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppointmentsItemLoading extends StatelessWidget {
  const AppointmentsItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage(
                      'assets/images/user.png',
                    ),
                    fit: BoxFit.fill,
                    width: 35,
                    height: 40,
                  ),
                ),
                horizontalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name', style: Theme.of(context).textTheme.bodyMedium),
                    Text('Speciality',
                        style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
                Spacer(),
                Icon(
                  IconBroken.Location,
                  size: 25,
                )
              ]),
              verticalSpace(10),
              Row(
                children: [
                  Icon(
                    IconBroken.Time_Circle,
                    size: 15,
                  ),
                  horizontalSpace(5),
                  Text('Time', style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DoctorCardOulinedButton(
                    onTap: () {},
                    withIcon: false,
                    buttonName: '',
                  ),
                  horizontalSpace(10),
                  DoctorCardButton(
                    onTap: () {},
                    buttonName: '',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
