import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/appointment_details/appointment_details.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppointmentDetailsLoading extends StatelessWidget {
  const AppointmentDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Padding(
          padding: const EdgeInsets.all(AppPreferances.padding),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(
                          color: AppColors.mainColor,
                        )),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: const AssetImage('assets/images/user.png'),
                          fit: BoxFit.fill,
                        )),
                  ),
                  horizontalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'name',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      verticalSpace(5),
                      Text(
                        'specialities',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      verticalSpace(5),
                      // Text(
                      //   model.doctor!.address!.isNotEmpty
                      //       ? model.doctor!.address![0].city!
                      //       : 'No Address',
                      //   style: Theme.of(context).textTheme.labelMedium,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            verticalSpace(10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'summary.appointmentDetails'.tr(),
                  //   style: Theme.of(context).textTheme.bodyLarge,
                  // ),
                  // verticalSpace(10),
                  AppointmentDetailsItem(title: 'summary.appId', value: '#123'),
                  verticalSpace(10),
                  AppointmentDetailsItem(title: 'summary.date', value: 'date'),
                  verticalSpace(10),
                  AppointmentDetailsItem(title: 'summary.time', value: 'time'),
                  verticalSpace(10),
                  AppointmentDetailsItem(
                      title: 'summary.status', value: 'status'),
                  verticalSpace(10),
                  AppointmentDetailsItem(
                      title: 'summary.appPrice', value: 'price'),
                  verticalSpace(20),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'summary.patientDetails'.tr(),
                  //       style: Theme.of(context).textTheme.bodyLarge,
                  //     ),
                  //     Spacer(),
                  //     Icon(
                  //       IconBroken.Edit,
                  //       color: AppColors.secondaryColor,
                  //       size: 20,
                  //     ),
                  //   ],
                  // ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  verticalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppointmentDetailsItem(
                          title: 'summary.name', value: 'name'),
                      verticalSpace(10),
                      AppointmentDetailsItem(
                          title: 'summary.age', value: 'age'),
                      verticalSpace(10),
                      AppointmentDetailsItem(
                        title: 'summary.gender',
                        value: 'age',
                      ),
                      verticalSpace(10),
                      AppointmentDetailsItem(
                        title: 'summary.phoneNumber',
                        value: 'phoneNumber',
                      ),
                      verticalSpace(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'summary.problem',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          verticalSpace(10),
                          Text(
                            'summary.problemDescription',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
