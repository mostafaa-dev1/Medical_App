import 'package:json_annotation/json_annotation.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/features/clinics/data/model/clinic_model.dart';
import 'package:medical_system/features/laboratories/data/model/labs_model.dart';

part 'appointments_model.g.dart';

@JsonSerializable()
class AppointmentList {
  List<Appointment>? appointments;
  AppointmentList({
    this.appointments,
  });
  factory AppointmentList.fromJson(List<Map<String, dynamic>> json) =>
      _$AppointmentListFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentListToJson(this);
}

@JsonSerializable()
class Appointment {
  int? id;
  @JsonKey(name: 'doctor_id')
  String? doctorId;
  @JsonKey(name: 'patient_id')
  String? patientId;
  @JsonKey(name: 'Doctors')
  Doctor? doctor;
  String? status;
  DateTime? date;
  String? time;
  String? type;
  @JsonKey(name: 'payment_method')
  String? paymentMethod;
  Patient? patient;
  @JsonKey(name: 'Clinics')
  Clinic? clinic;
  String? clinicId;
  ClinicInfo? hospital;
  int? hospitalId;
  int? labId;
  LabsInfo? lab;
  @JsonKey(name: 'lab_services')
  List<LabServices>? labServices;
  int? fee;

  Appointment({
    this.id,
    this.doctorId,
    this.patientId,
    this.doctor,
    this.status,
    this.date,
    this.time,
    this.type,
    this.paymentMethod,
    this.patient,
    this.clinic,
    this.clinicId,
    this.hospital,
    this.lab,
    this.labId,
    this.hospitalId,
    this.labServices,
    this.fee,
  });
  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}

@JsonSerializable()
class Patient {
  String? name;
  int? age;
  String? gender;
  String? phone;
  String? problem;
  Patient({
    this.name,
    this.age,
    this.gender,
    this.phone,
    this.problem,
  });
  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);
  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
