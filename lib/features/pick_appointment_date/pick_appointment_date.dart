import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PickAppointmentDate extends StatefulWidget {
  const PickAppointmentDate({super.key});

  @override
  State<PickAppointmentDate> createState() => _PickAppointmentDateState();
}

class _PickAppointmentDateState extends State<PickAppointmentDate> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    log(args.value.toString());
  }

  int? selectedTime;
  int? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Book Appointment',
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
                //context.pushNamed(AppRoutes.pickAppointmentDate);
              },
              buttonName: 'Next',
              width: 120,
              paddingVirtical: 5,
              height: 50,
              borderRadius: 20,
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
                  'Select Date',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
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
                verticalSpace(10),
                Wrap(
                  children: [
                    ...List.generate(
                        7,
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
                                  width: 80,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Feb',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: selectedDate == index
                                                  ? Colors.white
                                                  : null,
                                            ),
                                      ),
                                      Text(
                                        '2$index',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: selectedDate == index
                                                  ? Colors.white
                                                  : null,
                                            ),
                                      ),
                                      Text(
                                        'Friday',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: selectedDate == index
                                                  ? Colors.white
                                                  : null,
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
                  'Select Time',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                verticalSpace(10),
                Wrap(
                  children: [
                    ...List.generate(
                      20,
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
                            width: 100,
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
                            child: Center(
                              child: Text(
                                '${DateTime(2025, 2, 20, 11, 0).add(Duration(minutes: index * 30)).hour.toString()} : ${DateTime.now().add(Duration(minutes: index * 30)).minute.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: selectedTime == index
                                            ? Colors.white
                                            : AppColors.mainColor),
                              ),
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
