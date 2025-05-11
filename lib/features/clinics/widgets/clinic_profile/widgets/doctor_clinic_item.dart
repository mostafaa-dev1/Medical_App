import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/clinics/data/model/clinic_model.dart';

class DoctorClinicItem extends StatelessWidget {
  const DoctorClinicItem(
      {super.key,
      required this.doctor,
      required this.clinic,
      required this.user});
  final Doctor doctor;
  final ClinicInfo clinic;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
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
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: doctor.image!,
                  fit: BoxFit.fill,
                  height: 50,
                  width: 50,
                )),
            horizontalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${LanguageChecker.isArabic(context) ? doctor.firstNameAr! : doctor.firstName!} ${LanguageChecker.isArabic(context) ? doctor.lastNameAr! : doctor.lastName!}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                verticalSpace(5),
                Text(
                  'specialities.${doctor.specialty!}'.tr(),
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
                  '${doctor.rate} (${doctor.rateCount})',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                horizontalSpace(5),
              ],
            )
          ]),
          Row(
            children: [
              doctor.workTimes == null
                  ? Text(
                      'Not Available',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : buildNearestAvailableTimeWidget(doctor.workTimes!, context),
              Spacer(),
              CustomButton(
                  buttonName: 'appointments.bookNow'.tr(),
                  onPressed: () {
                    Appointment appointment = Appointment(
                      hospitalId: clinic.id,
                      doctorId: doctor.id,
                      hospital: clinic,
                      doctor: doctor,
                      fee: doctor.fee,
                      type: 'Upcoming',
                    );
                    context
                        .pushNamed(AppRoutes.pickAppointmentDate, arguments: {
                      'type': 'Clinic',
                      'appointment': appointment,
                      'workTimes': doctor.workTimes,
                      'user': user,
                      'reason': '',
                      'reschdule': false,
                      'appointmentId': '',
                      'doctorId': ''
                    });
                  },
                  height: 30,
                  width: 100,
                  paddingVirtical: 0,
                  paddingHorizental: 10)
            ],
          )
        ],
      ),
    );
  }

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
