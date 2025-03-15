import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/book_appointment/models/book_appointment.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  int? selectedTime;
  int? selectedDate;
  List<String> dayes = [
    'appointments.Monday'.tr(),
    'appointments.Tuesday'.tr(),
    'appointments.Wednesday'.tr(),
    'appointments.Thursday'.tr(),
    'appointments.Friday'.tr(),
    'appointments.Saturday'.tr(),
    'appointments.Sunday'.tr(),
  ];
  List<String> monthes = [
    'appointments.Jan'.tr(),
  ];
  List<DoctorAvailabilityModel> doctorAvailability = [
    DoctorAvailabilityModel(
        day: 'Monday',
        startTime: TimeOfDay(hour: 10, minute: 0),
        endTime: TimeOfDay(hour: 16, minute: 0),
        examinationDuration: 20),
    DoctorAvailabilityModel(
        day: 'Tuesday',
        startTime: TimeOfDay(hour: 10, minute: 0),
        endTime: TimeOfDay(hour: 16, minute: 0),
        examinationDuration: 20),
    DoctorAvailabilityModel(
        day: 'Wednesday',
        startTime: TimeOfDay(hour: 10, minute: 0),
        endTime: TimeOfDay(hour: 16, minute: 0),
        examinationDuration: 20),
    DoctorAvailabilityModel(
        day: 'Thursday',
        startTime: TimeOfDay(hour: 10, minute: 0),
        endTime: TimeOfDay(hour: 16, minute: 0),
        examinationDuration: 20),
  ];
  List<Map<String, String>> availableDays = [];
  List<Map<String, dynamic>> times = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    availableDays = getAvailableDays(doctorAvailability);
    times = calculateTime(
        doctorAvailability[0].startTime,
        doctorAvailability[0].endTime,
        doctorAvailability[0].examinationDuration);
  }

  List<Map<String, String>> getNext7Days() {
    DateTime today = DateTime.now();
    List<Map<String, String>> days = [];

    for (int i = 0; i < 7; i++) {
      DateTime futureDate = today.add(Duration(days: i));

      days.add({
        "dayName": i == 0
            ? "Today"
            : DateFormat.EEEE().format(futureDate), // "Today" if it's today
        "monthName": DateFormat.MMMM().format(futureDate), // e.g., March
        "dayNumber": DateFormat.d().format(futureDate), // e.g., 4
      });
    }
    return days;
  }

  List<Map<String, String>> getAvailableDays(
      List<DoctorAvailabilityModel> doctorAvailability) {
    DateTime today = DateTime.now();
    List<Map<String, String>> availableDays = [];

    for (int i = 0; i < 7; i++) {
      DateTime futureDate = today.add(Duration(days: i));
      String dayName = DateFormat.EEEE().format(futureDate);

      // Check if the current day is today
      String formattedDayName = (i == 0) ? "Today" : dayName;

      // Check if this day is in the doctor's availability
      if (doctorAvailability
          .any((availability) => availability.day == dayName)) {
        availableDays.add({
          "dayName":
              formattedDayName, // "Today" if it's today, otherwise the day name
          "monthName": DateFormat.MMMM().format(futureDate), // e.g., March
          "dayNumber": DateFormat.d().format(futureDate), // e.g., 4
        });
      }
    }

    return availableDays;
  }

  List<Map<String, dynamic>> calculateTime(
      TimeOfDay startTime, TimeOfDay endTime, int duration) {
    DateTime startDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      startTime.hour,
      startTime.minute,
    );

    DateTime endDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      endTime.hour,
      endTime.minute,
    );

    List<Map<String, dynamic>> times = [];

    while (startDateTime.isBefore(endDateTime)) {
      DateTime nextDateTime = startDateTime.add(Duration(minutes: duration));

      // Convert to 12-hour format
      int hour = startDateTime.hour > 12
          ? startDateTime.hour - 12
          : startDateTime.hour == 0
              ? 12
              : startDateTime.hour;
      int minute = startDateTime.minute;

      String period = startDateTime.hour >= 12 ? 'pm' : 'am';

      times.add({
        'hour': hour.toString().padLeft(2, '0'),
        'minute': minute.toString().padLeft(2, '0'),
        'period': period,
      });

      startDateTime = nextDateTime;
    }

    return times;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'appointments.bookAppointment'.tr(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 50,
          padding: EdgeInsets.zero,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: CustomButton(
              onPressed: () {
                context.pushNamed(AppRoutes.patientAppointmentDetails);
              },
              buttonName: 'appointments.next'.tr(),
              width: 120,
              paddingVirtical: 5,
              height: 50,
              paddingHorizental: 10,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPreferances.padding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'appointments.selectDate'.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                verticalSpace(10),
                Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  textDirection: ui.TextDirection.rtl,
                  children: [
                    ...List.generate(
                        availableDays.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDate = index;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColors.mainColor,
                                      width: 2,
                                    ),
                                    color: selectedDate == index
                                        ? AppColors.mainColor
                                        : Theme.of(context)
                                            .scaffoldBackgroundColor,
                                  ),
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        'appointments.${availableDays[index]['dayName']}'
                                            .tr(), // Day names
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: selectedDate == index
                                                  ? Colors.white
                                                  : AppColors.mainColor,
                                            ),
                                      ),
                                      Text(
                                        availableDays[index]
                                            ['dayNumber']!, // Day numbers
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: selectedDate == index
                                                  ? Colors.white
                                                  : AppColors.mainColor,
                                            ),
                                      ),
                                      Text(
                                        'appointments.${availableDays[index]['monthName']}'
                                            .tr(), // Month names
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: selectedDate == index
                                                  ? Colors.white
                                                  : AppColors.mainColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                  ],
                ),
                verticalSpace(20),
                Text(
                  'appointments.selectTime'.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                verticalSpace(10),
                Wrap(
                  children: [
                    ...List.generate(
                      times.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTime = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 110,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: selectedTime == index
                                  ? AppColors.mainColor
                                  : Theme.of(context).scaffoldBackgroundColor,
                              border: Border.all(
                                color: AppColors.mainColor,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${times[index]['hour']}:${times[index]['minute']}', // available times
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: selectedTime == index
                                            ? Colors.white
                                            : AppColors.mainColor,
                                      ),
                                  textDirection: ui.TextDirection.ltr,
                                ),
                                horizontalSpace(5),
                                Text(
                                    'appointments.${times[index]['period']}'
                                        .tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: selectedTime == index
                                              ? Colors.white
                                              : AppColors.mainColor,
                                        ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

 // verticalSpace(10),
                // SizedBox(
                //   height: 300,
                //   width: double.infinity,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(20),
                //     child: Localizations.override(
                //       context: context,
                //       locale: const Locale('ar'),
                //       delegates: [],
                //       child: SfDateRangePicker(
                //         backgroundColor: Theme.of(context).cardColor,
                //         enableMultiView: false,
                //         headerStyle: DateRangePickerHeaderStyle(
                //           textAlign: TextAlign.center,
                //           textStyle: Theme.of(context)
                //               .textTheme
                //               .bodyMedium!
                //               .copyWith(color: Colors.white),
                //           backgroundColor: AppColors.mainColor,
                //         ),
                //         onSelectionChanged: _onSelectionChanged,
                //         selectionColor: AppColors.mainColor,
                //         selectionShape: DateRangePickerSelectionShape.circle,
                //         selectionRadius: 20,
                //         selectionMode: DateRangePickerSelectionMode.single,
                //         maxDate: DateTime.now().add(const Duration(days: 5)),
                //         enablePastDates: false,
                //         todayHighlightColor: AppColors.mainColor,
                //         monthCellStyle: DateRangePickerMonthCellStyle(
                //             blackoutDateTextStyle: Theme.of(context)
                //                 .textTheme
                //                 .bodyMedium!
                //                 .copyWith(color: Colors.red),
                //             textStyle: Theme.of(context).textTheme.bodyMedium,
                //             todayTextStyle:
                //                 Theme.of(context).textTheme.bodyMedium),
                //         selectionTextStyle:
                //             Theme.of(context).textTheme.bodyMedium!.copyWith(
                //                   color: Colors.white,
                //                 ),
                //         monthViewSettings: DateRangePickerMonthViewSettings(
                //             viewHeaderStyle: DateRangePickerViewHeaderStyle(
                //               textStyle: Theme.of(context)
                //                   .textTheme
                //                   .bodyMedium!
                //                   .copyWith(color: Colors.white),
                //               backgroundColor: AppColors.mainColor,
                //             ),
                //             firstDayOfWeek: 6,
                //             weekendDays: [DateTime.friday],
                //             blackoutDates: []),
                //       ),
                //     ),
                //   ),
                // ),
                // Theme(
                //   data: Theme.of(context).copyWith(
                //       colorScheme:
                //           ColorScheme.fromSeed(seedColor: AppColors.mainColor)),
                //   child: Builder(
                //     builder: (context) {
                //       return EasyTheme(
                //         data: EasyTheme.of(context).copyWith(
                //           currentDayBackgroundColor:
                //               WidgetStatePropertyAll(AppColors.mainColor),
                //           timelineOptions: const TimelineOptions(
                //             height: 64.0,
                //           ),
                //           currentDayMiddleElementStyle: WidgetStatePropertyAll(
                //               Theme.of(context).textTheme.bodyMedium!),
                //           dayTopElementStyle: WidgetStatePropertyAll(
                //               Theme.of(context).textTheme.bodyMedium!),
                //           currentMonthBackgroundColor:
                //               WidgetStatePropertyAll(AppColors.mainColor),
                //           currentMonthShape:
                //               WidgetStatePropertyAll(RoundedRectangleBorder(
                //                   side: BorderSide(
                //                     color: AppColors.darkBlue,
                //                   ),
                //                   borderRadius: BorderRadius.circular(8.0))),
                //           dayShape:
                //               WidgetStatePropertyAll(RoundedRectangleBorder(
                //                   side: BorderSide(
                //                     color: AppColors.darkBlue,
                //                   ),
                //                   borderRadius: BorderRadius.circular(8.0))),
                //           currentMonthStyle: WidgetStatePropertyAll(
                //               Theme.of(context).textTheme.bodyMedium!),
                //           dayBottomElementStyle: WidgetStatePropertyAll(
                //               Theme.of(context).textTheme.bodyMedium!),
                //           dayBorder: WidgetStatePropertyAll(
                //             BorderSide(
                //               color: Theme.of(context).canvasColor,
                //             ),
                //           ),
                //         ),
                //         child: EasyDateTimeLinePicker(
                //           locale: Locale('en'),
                //           firstDate: DateTime.now(),
                //           lastDate: DateTime(2030, 3, 18),
                //           focusedDate: DateTime.now(),
                //           onDateChange: (selectedDate) {
                //             // setState(() {
                //             //   _selectedDate = selectedDate;
                //             // });
                //           },
                //         ),
                //       );
                //     },
                //   ),
                //),
