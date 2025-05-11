import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/networking/notifications/local_notifications.dart';
import 'package:medical_system/features/appointments/data/data_service/appointments_data.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/book_appointment/select_date_time/data/services/book_appointment_data.dart';
import 'package:meta/meta.dart';

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTimeCubit() : super(DateTimeInitial());

  final _data = BookAppointmentData();
  final _appointmentsData = AppointmentsData();

  DateTime? _selectedDate;
  List<Map<String, String>> availableDays = [];
  List<Map<String, dynamic>> times = [];
  List<Map<String, dynamic>> appointmentTimes = [];

  Future<void> getAvailableTimes(
      String date, String eqvalue, String eqkey) async {
    appointmentTimes = [];
    emit(GetAvailableTimesLoading());
    final response = await _data.getAppointmentTimes(
        eqkey: eqkey, eqvalue: eqvalue, date: date);
    response.fold((l) {
      emit(BookAppointmentError(l));
    }, (r) {
      log(r.toString());
      for (var element in r) {
        appointmentTimes.add({
          'date': element['date'],
          'time': element['time'],
        });
      }
      log(appointmentTimes.toString());
      emit(GetAvailableTimesSuccess());
    });
  }

  void getAvailableDays(WorkTimes doctorAvailability) {
    DateTime today = DateTime.now();
    // List<Map<String, String>> dayes = [];

    for (int i = 0; i < 7; i++) {
      DateTime futureDate = today.add(Duration(days: i));
      String dayName = DateFormat.EEEE().format(futureDate);

      // Check if the current day is today
      String formattedDayName = (i == 0)
          ? "Today"
          : (i == 1)
              ? "Tomorrow"
              : dayName;

      // Check if this day is in the doctor's availability
      if (doctorAvailability.workTimes!
          .any((availability) => availability.day == dayName)) {
        availableDays.add({
          "dayName":
              formattedDayName, // "Today" if it's today, otherwise the day name
          "monthName": DateFormat.MMMM().format(futureDate), // e.g., March
          "dayNumber": DateFormat.d().format(futureDate),
          "year": DateFormat.y().format(futureDate),
          "monthNumber": DateFormat.M().format(futureDate), // e.g., 3
        });
      }
    }
    emit(AvailableDaysState());
  }

  int? selectedDay;
  void selectDay(int index) {
    selectedDay = index;
    emit(AvailableDaysState());
  }

  int? selectedTime;
  void selectTime(int index) {
    selectedTime = index;
    emit(AvailableTimesState());
  }

  String? fitchDate;
  Future<void> calculateTime(DateTime startTime, DateTime endTime, int duration,
      String eqvalue, String eqkey) async {
    if (selectedDay == null || availableDays.isEmpty) return;

    // Parse selected date from availableDays list
    final selectedDateMap = availableDays[selectedDay!];
    DateTime selectedDate = DateTime(
      int.parse(selectedDateMap['year']!),
      int.parse(selectedDateMap['monthNumber']!),
      int.parse(selectedDateMap['dayNumber']!),
    );

    // Filter appointment times for selected day
    String formatedDate =
        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
    if (fitchDate != formatedDate) {
      fitchDate = formatedDate;
      await getAvailableTimes(
        formatedDate,
        eqvalue,
        eqkey,
      );
    }

    DateTime startDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      startTime.hour,
      startTime.minute,
    );

    DateTime endDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      endTime.hour,
      endTime.minute,
    );

    List<Map<String, dynamic>> generatedSlots = [];
    times = [];

    while (startDateTime.isBefore(endDateTime)) {
      generatedSlots.add({
        'hour': startDateTime.hour.toString(),
        'minute': startDateTime.minute.toString(),
      });
      startDateTime = startDateTime.add(Duration(minutes: duration));
    }
    //Filter out booked slots
    if (appointmentTimes.isEmpty) {
      times = generatedSlots;
      return;
    }
    checkAvailability(generatedSlots);

    emit(AvailableTimesState());
  }

  void checkAvailability(List<Map<String, dynamic>> generatedSlots) {
    for (int i = 0; i < appointmentTimes.length; i++) {
      for (int j = 0; j < generatedSlots.length; j++) {
        String solted =
            '${generatedSlots[j]['hour']!.toString().padLeft(2, '0')}:${generatedSlots[j]['minute'].toString().padLeft(2, '0')}:00';
        if (appointmentTimes[i]['time'] == solted) {
          //generatedSlots.remove(slot);
          //i++;
          generatedSlots.remove(generatedSlots[j]);
        }
      }
    }
    times = generatedSlots;
  }

  Appointment? appointment;
  void selectedDateTime(Map<String, dynamic> date, Map<String, dynamic> time,
      String doctorId, Appointment appoint) {
    appointment = appoint;

    _selectedDate = DateTime(
      int.parse(date['year']!),
      int.parse(date['monthNumber']!),
      int.parse(date['dayNumber']!),
      int.parse(time['hour']!),
      int.parse(time['minute']!),
    );
    appointment!.date = _selectedDate;
    appointment!.time =
        '${_selectedDate!.hour.toString().padLeft(2, '0')}:${_selectedDate!.minute.toString().padLeft(2, '0')}:00';
    // appointment = Appointment(
    //   doctorId: doctorId,
    //   date: _selectedDate,
    //   time:
    //       '${_selectedDate!.hour.toString().padLeft(2, '0')}:${_selectedDate!.minute.toString().padLeft(2, '0')}:00',
    // );
    // String date = '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}';
    // String time = '${_selectedDate!.hour.toString().padLeft(2, '0')}:${_selectedDate!.minute.toString().padLeft(2, '0')}:00';
  }

  Future<void> rescheduleAppointment(
      String id, String reason, Appointment? appointment) async {
    emit(RescheduleAppointmentLoading());
    final response = await _appointmentsData.rescheduleAppointment(
        id: id,
        date: DateFormat('yyyy-MM-dd').format(appointment!.date!),
        time: appointment.time!,
        reason: reason);
    response.fold((error) {
      emit(RescheduleAppointmentError(error));
    }, (data) {
      secheduleNotification({
        'date': DateFormat('yyyy-MM-dd').format(appointment.date!),
        'time': appointment.time!,
        'id': id,
      }, appointment.doctorId!);
      emit(RescheduleAppointmentSuccess());
    });
  }

  Future<void> secheduleNotification(
      Map<String, dynamic> response, String doctor) async {
    await LocalNotifications.showNotification(
      title: 'dialog.bookSuccess'.tr(),
      body: 'dialog.appointmentBooked'.tr(),
    );
    await LocalNotifications.secheduleNotification(
      title: 'dialog.todayAppointment'.tr(),
      body: '${'dialog.dontMissTodayAppointment'.tr()}$doctor',
      dateTime: parseDateTime(
        response['date'].toString(),
        response['time'].toString(),
      ).subtract(
        const Duration(hours: 1),
      ),
      id: response['id'],
    );
    await LocalNotifications.secheduleNotification(
      title: 'dialog.onHourToAppointment'.tr(),
      body: '${'dialog.dontMissAppointment'.tr()}$doctor',
      dateTime: parseDate(
        response['date'].toString(),
      ),
      id: response['id'] + 100000,
    );
  }

  DateTime parseDateTime(String date, String time) {
    String hour = time.split(':')[0];
    String minute = time.split(':')[1];
    String dateTimeString = '$date $hour:$minute:00';
    log(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString).toString());
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString);
  }

  DateTime parseDate(String date) {
    return DateFormat('yyyy-MM-dd').parse(date);
  }
}
