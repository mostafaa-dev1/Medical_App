import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/logic/app_cubit.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/core/widgets/stepper.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/book_appointment/select_date_time/logic/date_time_cubit.dart';
import 'package:medical_system/features/book_appointment/select_date_time/widgets/dayes.dart';
import 'package:medical_system/features/book_appointment/select_date_time/widgets/times.dart';

class DateAndTime extends StatelessWidget {
  const DateAndTime(
      {super.key,
      //required this.workTimes,
      required this.user,
      //required this.clinic,
      required this.appointment,
      required this.appointMentId,
      required this.reschdule,
      required this.reason,
      required this.doctorId,
      required this.workTimes});
  final WorkTimes workTimes;
  final UserModel user;
  // final Clinic clinic;
  final Appointment appointment;
  final String appointMentId;
  final bool reschdule;
  final String reason;
  final String doctorId;
  // List<Map<String, String>> getNext7Days() {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DateTimeCubit, DateTimeState>(
      listener: (context, state) {
        if (state is RescheduleAppointmentError) {
          showCustomDialog(
            context: context,
            message: 'appointments.appointmentError'.tr(),
            title: 'dialog.oops',
            onConfirmPressed: () => context.pop(),
            confirmButtonName: 'dialog.ok'.tr(),
            dialogType: DialogType.error,
          );
        } else if (state is RescheduleAppointmentSuccess) {
          showCustomDialog(
            context: context,
            message: 'appointments.appointRescheduled'.tr(),
            title: 'dialog.sentSuccess'.tr(),
            onConfirmPressed: () => context.pushNamedAndRemoveUntil(
              AppRoutes.mainScreen,
            ),
            confirmButtonName: 'dialog.ok'.tr(),
            dialogType: DialogType.success,
          );
          context.read<AppCubit>().addNotification(
              content: 'Appointment has been rescheduled successfully',
              contentAr: 'تم تغيير الموعد بنجاح',
              patientId: user.id!,
              type: 'Scheduled');
        }
      },
      builder: (context, state) {
        var bookAppointmentCubit = context.read<DateTimeCubit>();
        var availableDays = bookAppointmentCubit.availableDays;
        var times = bookAppointmentCubit.times;
        String eqKey = appointment.clinic != null
            ? 'doctor_id'
            : appointment.hospital != null
                ? 'hos_id'
                : appointment.lab != null
                    ? 'lab_id'
                    : '';
        String eqValue = appointment.clinic != null
            ? appointment.clinic!.id.toString()
            : appointment.hospital != null
                ? appointment.hospital!.id.toString()
                : appointment.lab != null
                    ? appointment.lab!.id.toString()
                    : '';
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'appointments.bookAppointment'.tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            persistentFooterButtons: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: CustomButton(
                  onPressed: () {
                    if (bookAppointmentCubit.selectedTime == null) {
                      return;
                    }
                    if (reschdule) {
                      print(reason);
                      bookAppointmentCubit.selectedDateTime(
                          availableDays[bookAppointmentCubit.selectedDay!],
                          times[bookAppointmentCubit.selectedTime!],
                          doctorId,
                          appointment);
                      bookAppointmentCubit.rescheduleAppointment(
                          appointMentId, reason, appointment);
                    } else {
                      bookAppointmentCubit.selectedDateTime(
                          availableDays[bookAppointmentCubit.selectedDay!],
                          times[bookAppointmentCubit.selectedTime!],
                          doctorId,
                          appointment);
                      // log('${availableDays[selectedDate!]['dayNumber']}');
                      // log('${times[selectedTime!]['hour']}');
                      // log('${times[selectedTime!]['minute']}');
                      // selectedDateTime(
                      //     availableDays[selectedDate!], times[selectedTime!]);
                      context.pushNamed(AppRoutes.patientAppointmentDetails,
                          arguments: {
                            'appointment': bookAppointmentCubit.appointment,
                            'user': user,
                            // 'doctor': appointment.c linic
                          });
                    }
                  },
                  isLoading: state is RescheduleAppointmentLoading,
                  buttonName: 'appointments.next'.tr(),
                  width: double.infinity,
                  paddingVirtical: 5,
                  backgroundColor: bookAppointmentCubit.selectedTime == null
                      ? Theme.of(context).cardColor
                      : AppColors.mainColor,
                  height: 40,
                  paddingHorizental: 10,
                ),
              ),
            ],
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppointmentStepper(
                      index: 0, text: 'appointments.selectDateAndTime'.tr()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPreferances.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(10),
                        Text(
                          'appointments.selectDate'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        verticalSpace(10),
                        Dayes(
                            workTimes: workTimes,
                            eqkey: eqKey,
                            eqvalue: eqValue),
                        verticalSpace(20),
                        Text(
                          'appointments.selectTime'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        verticalSpace(10),
                        Times()
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
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
