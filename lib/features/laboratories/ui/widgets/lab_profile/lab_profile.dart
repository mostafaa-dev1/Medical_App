import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/laboratories/data/model/labs_model.dart';
import 'package:medical_system/features/laboratories/logic/laboratories_cubit.dart';

class LabProfile extends StatelessWidget {
  const LabProfile({super.key, required this.lab, required this.user});
  final LabsInfo lab;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaboratoriesCubit, LaboratoriesState>(
      builder: (context, state) {
        var cubit = context.read<LaboratoriesCubit>();
        return Scaffold(
          persistentFooterButtons: [
            CustomButton(
              buttonName:
                  '${'laboratories.next'.tr()} ${Format.formatNumber(cubit.cart.length, context)}(${Format.formatPrice(cubit.total.toInt(), context)})',
              onPressed: () {
                Appointment appointment = Appointment(
                  lab: lab,
                  patientId: user.id,
                  labId: lab.id,
                  type: 'Upcoming',
                  labServices: cubit.cart,
                  fee: cubit.total.toInt(),
                );
                context.pushNamed(AppRoutes.pickAppointmentDate, arguments: {
                  'type': 'Clinic',
                  'appointment': appointment,
                  'workTimes': lab.workTimes,
                  'user': user,
                  'reason': '',
                  'reschdule': false,
                  'appointmentId': '',
                  'doctorId': ''
                });
              },
              width: double.infinity,
              height: 40,
              paddingHorizental: 10,
              paddingVirtical: 0,
            ),
          ],
          appBar: AppBar(
            title: Text(
              LanguageChecker.isArabic(context)
                  ? lab.lab!.nameAr!
                  : lab.lab!.name!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: Column(
            children: [
              Container(
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
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: lab.lab!.image!,
                            fit: BoxFit.fill,
                            height: 90,
                            width: 90,
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          // <-- Wrap Column with Expanded
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    LanguageChecker.isArabic(context)
                                        ? lab.lab!.nameAr!
                                        : lab.lab!.name!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                                        Format.formatNumber(
                                            lab.lab!.rate ?? 0, context),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      horizontalSpace(5),
                                      Text(
                                        '(${Format.formatNumber(lab.lab!.rateCount ?? 0, context)})',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              verticalSpace(5),
                              Text(
                                'laboratories.${lab.lab!.specialty!}'.tr(),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              verticalSpace(5),
                              Row(
                                children: [
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: 8, vertical: 4), // Add padding
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(10),
                                  //     color: AppColors.mainColor.withAlpha(20),
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisSize: MainAxisSize
                                  //         .min, // Important to prevent taking full width
                                  //     children: [
                                  //       Icon(Icons.home, size: 16), // reduce size a little
                                  //       horizontalSpace(5),
                                  //       Text(
                                  //         Format.formatNumber(lab.patients ?? 0, context),
                                  //         style: Theme.of(context).textTheme.bodySmall,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  lab.lab!.services!.contains("Sampling")
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4), // Add padding
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.mainColor
                                                .withAlpha(20),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize
                                                .min, // Important to prevent taking full width
                                            children: [
                                              Icon(Icons.home,
                                                  size:
                                                      16), // reduce size a little
                                              horizontalSpace(5),
                                              Text(
                                                'laboratories.sampling'.tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.mainColor,
                          size: 15,
                        ),
                        horizontalSpace(5),
                        Text(
                          '${'government.${lab.government!}'.tr()}, ${'city.${lab.city!}'.tr()}, ${LanguageChecker.isArabic(context) ? lab.address!.streatAr : lab.address!.streat}, ${LanguageChecker.isArabic(context) ? lab.address!.buildingAr : lab.address!.building}',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: AppColors.mainColor,
                          size: 15,
                        ),
                        horizontalSpace(5),
                        buildNearestAvailableTimeWidget(lab.workTimes!, context)
                      ],
                    )
                  ],
                ),
              ),
              Container(
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
                    ],
                  ),
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              cubit.changeServiceIndex(0);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4), // Add padding
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: cubit.selectedIndex == 0
                                    ? AppColors.mainColor
                                    : AppColors.mainColor.withAlpha(20),
                              ),
                              child: Center(
                                child: Text(
                                  'laboratories.inLab'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: cubit.selectedIndex == 0
                                            ? Colors.white
                                            : null,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              cubit.changeServiceIndex(1);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4), // Add padding
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: cubit.selectedIndex == 1
                                    ? AppColors.mainColor
                                    : AppColors.mainColor.withAlpha(20),
                              ),
                              child: Center(
                                child: Text(
                                  'laboratories.homeSample'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: cubit.selectedIndex == 1
                                            ? Colors.white
                                            : null,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(20),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: lab.services!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 30,
                                child: Row(
                                  children: [
                                    Text(
                                      LanguageChecker.isArabic(context)
                                          ? lab.services![index].serviceAr
                                          : lab.services![index].service,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Spacer(),
                                    Text(
                                      Format.formatPrice(
                                          int.parse(lab.services![index].price),
                                          context),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    horizontalSpace(10),
                                    GestureDetector(
                                      onTap: () {
                                        cubit.addToCart(
                                            lab.services![index], index);
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color:
                                              cubit.cartIndexes.contains(index)
                                                  ? AppColors.mainColor
                                                      .withAlpha(20)
                                                  : AppColors.mainColor,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                  thickness: 0.5,
                                  color: Theme.of(context).dividerColor)
                            ],
                          );
                        })
                  ]))
            ],
          ),
        );
      },
    );
  }

  // bool calculateAvailability(LabWorkTime workTime) {
  //   DateTime now = DateTime.now();

  //   // Prepare list of days
  //   List<String> days = [
  //     'Monday',
  //     'Tuesday',
  //     'Wednesday',
  //     'Thursday',
  //     'Friday',
  //     'Saturday',
  //     'Sunday'
  //   ];

  //   // Get today's weekday name
  //   //String today = days[now.weekday - 1];

  //   // Get indexes of from and to
  //   int fromIndex = days.indexOf(workTime.from!);
  //   int toIndex = days.indexOf(workTime.to!);

  //   // Handle wrap around (ex: from Friday to Monday)
  //   bool isTodayInRange;
  //   if (fromIndex <= toIndex) {
  //     isTodayInRange =
  //         now.weekday - 1 >= fromIndex && now.weekday - 1 <= toIndex;
  //   } else {
  //     // Example: from Friday to Monday
  //     isTodayInRange =
  //         now.weekday - 1 >= fromIndex || now.weekday - 1 <= toIndex;
  //   }

  //   if (isTodayInRange) {
  //     // Only if today is between from and to, check the time
  //     DateTime startTime = DateTime(
  //       now.year,
  //       now.month,
  //       now.day,
  //       workTime.start!.hour,
  //       workTime.start!.minute,
  //     );
  //     DateTime endTime = DateTime(
  //       now.year,
  //       now.month,
  //       now.day,
  //       workTime.end!.hour,
  //       workTime.end!.minute,
  //     );

  //     if (now.isAfter(startTime) && now.isBefore(endTime)) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return false;
  //   }
  // }
  String getNearestAvailableDay(
      List<WorkTime> workTimes, BuildContext context) {
    DateTime now = DateTime.now();
    List<String> weekDays = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    // Convert WorkTime list to DateTime objects
    List<DateTime> availableDates = [];

    for (var workTime in workTimes) {
      int targetWeekDay = weekDays.indexOf(workTime.day ?? '');
      if (targetWeekDay == -1 || workTime.start == null) continue;

      int todayWeekDay = now.weekday % 7; // Adjust to 0-6 format
      int daysToAdd = (targetWeekDay - todayWeekDay) % 7;
      if (daysToAdd < 0) daysToAdd += 7;

      DateTime availableDate = now.add(Duration(days: daysToAdd));

      DateTime availableDateTime = DateTime(
        availableDate.year,
        availableDate.month,
        availableDate.day,
        workTime.start!.hour,
        workTime.start!.minute,
      );

      availableDates.add(availableDateTime);
    }

    // Sort by earliest available slot
    availableDates.sort((a, b) => a.compareTo(b));

    if (availableDates.isEmpty) return 'search.noAvailabltimes'.tr();

    DateTime nearestDate = availableDates.first;
    String formattedTime =
        DateFormat('hh:mm a', LanguageChecker.isArabic(context) ? 'ar' : 'en')
            .format(nearestDate);

    if (nearestDate.day == now.day) {
      return "${'search.todayAt'.tr()} $formattedTime";
    } else if (nearestDate.day == now.add(Duration(days: 1)).day) {
      return "${'search.tomorrowAt'.tr()} $formattedTime";
    } else {
      return "${DateFormat('EEEE', LanguageChecker.isArabic(context) ? 'ar' : 'en').format(nearestDate)} ${'search.at'.tr()} $formattedTime";
    }
  }

  Text buildNearestAvailableTimeWidget(
      WorkTimes workTimes, BuildContext context) {
    String nearestTime =
        '${'search.available'.tr()} ${getNearestAvailableDay(workTimes.workTimes ?? [], context)}';

    return Text(
      nearestTime,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: AppColors.mainColor,
          ),
    );
  }
}
