// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentList _$AppointmentListFromJson(List<Map<String, dynamic>> json) =>
    AppointmentList(
      appointments: json.map((e) => Appointment.fromJson(e)).toList(),
    );

Map<String, dynamic> _$AppointmentListToJson(AppointmentList instance) =>
    <String, dynamic>{
      'appointments': instance.appointments,
    };

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: (json['id'] as num?)?.toInt(),
      doctorId: json['doctor_id'] as String?,
      patientId: json['patient_id'] as String?,
      clinicId: json['clinic_id'] as String?,
      doctor: json['Doctors'] == null
          ? null
          : Doctor.fromJson(json['Doctors'] as Map<String, dynamic>),
      status: json['status'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      time: json['time'] as String?,
      type: json['type'] as String?,
      paymentMethod: json['payment_method'] as String?,
      patient: json['patient'] == null
          ? null
          : Patient.fromJson(json['patient'] as Map<String, dynamic>),
      clinic: json['Clinics'] == null
          ? null
          : Clinic.fromJson(json['Clinics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'doctor_id': instance.doctorId,
      'patient_id': instance.patientId,
      'status': instance.status,
      'date': instance.date?.toIso8601String(),
      'time': instance.time,
      'type': instance.type,
      'payment_method': instance.paymentMethod,
      'patient': instance.patient,
      'clinic_id': instance.clinicId,
    };

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      name: json['name'] as String?,
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      problem: json['problem'] as String?,
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'phone': instance.phone,
      'problem': instance.problem,
    };
