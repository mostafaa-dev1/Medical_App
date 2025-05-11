import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medical_system/features/appointments/data/data_service/appointments_data.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:meta/meta.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit() : super(AppointmentsInitial());
  final _appointmentsData = AppointmentsData();

  AppointmentList upcomingVisits = AppointmentList();
  AppointmentList completedVisits = AppointmentList();
  AppointmentList canceledVisits = AppointmentList();
  int selectedIndex = 0;
  Future<void> getAppointments(
      {required String eqKey2,
      required String eqValue2,
      required int index,
      required String patientId}) async {
    emit(GetAppointmentsLoading());
    selectedIndex = index;
    final response = await _appointmentsData.getAppointments(
        patientId: patientId, eqKey2: eqKey2, eqValue2: eqValue2);
    response.fold((error) {
      emit(GetAppointmentsError(error));
    }, (data) {
      if (data.isEmpty) {
        emit(GetAppointmentsSuccess());

        return;
        //emit(GetAppointmentsSuccess());
      }
      log(data.toString());
      if (eqValue2 == 'Upcoming') {
        upcomingVisits = AppointmentList.fromJson(data);
        // log(upcomingVisits.appointments![0].clinic!.doctor!.id.toString());
      } else if (eqValue2 == 'Completed') {
        completedVisits = AppointmentList.fromJson(data);
        // print(completedVisits.appointments![0].doctor!.image);
      } else {
        canceledVisits = AppointmentList.fromJson(data);
      }
      emit(GetAppointmentsSuccess());
    });
  }

  final List<String> reasons = [
    'appointments.anotherDoctor'.tr(),
    'appointments.recoveredIllness'.tr(),
    'appointments.suitableMedicine'.tr(),
    'appointments.moneyIssue'.tr(),
    'appointments.personalReason'.tr(),
    'appointments.justCancel'.tr()
  ];
  int selectedCancelIndex = 0;
  String? selectedReason;

  void selectCancelIndex(int index) {
    selectedCancelIndex = index;
    selectedReason = reasons[index];
    emit(SelectCancelIndexState());
  }

  Future<void> cancelAppointment(String reason, Appointment appointment) async {
    emit(CancelAppointmentLoading());
    final response = await _appointmentsData.cancelAppointment(
        id: appointment.id!.toString(), reason: reason);
    response.fold((error) {
      emit(CancelAppointmentError(error));
    }, (data) {
      // upcomingVisits.appointments!.removeWhere((element) {
      //   log(element.id.toString());
      //   log(appointment.id.toString());
      //   return element.id == appointment.id;
      // });
      //log(upcomingVisits.appointments.toString());
      canceledVisits.appointments ??= [];
      canceledVisits.appointments!.add(appointment);
      emit(CancelAppointmentSuccess());
    });
  }

  // Future<void> rescheduleAppointment(
  //     String id, String date, String time, String reason) async {
  //   emit(RescheduleAppointmentLoading());
  //   final response = await _appointmentsData.rescheduleAppointment(
  //       id: id, date: date, time: time, reason: reason);
  //   response.fold((error) {
  //     emit(RescheduleAppointmentError(error));
  //   }, (data) {
  //     emit(RescheduleAppointmentSuccess());
  //   });
  // }

  Appointment? appointment;

  Future<void> getAppointment(int id) async {
    emit(GetAppointmentsLoading());
    final response = await _appointmentsData.getGetAppointment(id: id);
    response.fold((error) {
      emit(GetAppointmentsError(error));
    }, (data) {
      log(data.toString());
      appointment = Appointment.fromJson(data[0]);
      emit(GetAppointmentsSuccess());
    });
  }
}
