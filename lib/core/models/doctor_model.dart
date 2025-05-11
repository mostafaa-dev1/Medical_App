import 'package:json_annotation/json_annotation.dart';
import 'package:medical_system/features/laboratories/data/model/labs_model.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class Doctor {
  String? id;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'first_name_ar')
  String? firstNameAr;
  @JsonKey(name: 'last_name_ar')
  String? lastNameAr;
  String? email;
  @JsonKey(defaultValue: '')
  String? image;
  String? phone;
  String? gender;
  String? uid;
  String? specialty;
  @JsonKey(name: 'work_times')
  WorkTimes? workTimes;
  double? rate;
  @JsonKey(name: 'rate_count')
  int? rateCount;
  @JsonKey(defaultValue: [])
  List<Address>? address;
  @JsonKey(name: 'Clinics')
  List<Clinic>? clinic;
  @JsonKey(name: 'DoctorsInfo')
  DoctorInfo? doctorInfo;
  int? fee;

  Doctor(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.image,
      this.phone,
      this.gender,
      this.uid,
      this.specialty,
      this.address,
      this.clinic,
      this.doctorInfo,
      this.firstNameAr,
      this.lastNameAr,
      this.workTimes,
      this.rate,
      this.rateCount,
      this.fee});
  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}

@JsonSerializable()
class DoctorInfo {
  String? id;

  String? about;
  @JsonKey(name: 'about_ar')
  String? aboutAr;
  List<dynamic>? experience;
  @JsonKey(name: 'experience_ar')
  List<dynamic>? experienceAr;
  List<dynamic>? education;
  @JsonKey(name: 'education_ar')
  List<dynamic>? educationAr;
  List<dynamic>? specialities;
  @JsonKey(name: 'specialities_ar')
  List<dynamic>? specialitiesAr;
  @JsonKey(name: 'date_of_birth')
  String? dateOfBirth;
  int? patients;

  DoctorInfo({
    this.id,
    this.about,
    this.aboutAr,
    this.experience,
    this.experienceAr,
    this.education,
    this.educationAr,
    this.specialities,
    this.specialitiesAr,
    this.dateOfBirth,
    this.patients,
  });
  factory DoctorInfo.fromJson(Map<String, dynamic> json) =>
      _$DoctorInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorInfoToJson(this);
}

@JsonSerializable()
class Clinic {
  String? id;
  @JsonKey(name: 'doctor_id')
  String? doctorId;
  List<dynamic>? latLong;
  double? lattitude;
  double? longitude;
  String? government;
  String? city;
  @JsonKey(defaultValue: 0)
  int? fee;
  @JsonKey(defaultValue: 0.0)
  double? rate;
  @JsonKey(defaultValue: 0, name: 'rate_count')
  int? rateCount;
  // String? street;
  List<String>? phones;
  List<dynamic>? services;
  @JsonKey(name: 'work_times')
  WorkTimes? workTimes;
  @JsonKey(name: 'Doctors')
  Doctor? doctor;
  @JsonKey(name: 'DoctorsInfo')
  DoctorInfo? doctorInfo;
  Address? address;

  Clinic(
      {this.id,
      this.doctorId,
      this.latLong,
      this.lattitude,
      this.longitude,
      this.government,
      this.city,
      // this.street,
      this.phones,
      this.services,
      this.workTimes,
      this.doctor,
      this.doctorInfo,
      this.fee,
      this.rate,
      this.rateCount,
      this.address});
  factory Clinic.fromJson(Map<String, dynamic> json) => _$ClinicFromJson(json);
  Map<String, dynamic> toJson() => _$ClinicToJson(this);
}

@JsonSerializable()
class Clinics {
  List<Clinic>? clinics;

  Clinics({this.clinics});
  factory Clinics.fromJson(List<dynamic> json) => _$ClinicsFromJson(json);
  Map<String, dynamic> toJson() => _$ClinicsToJson(this);
}

@JsonSerializable()
class WorkTime {
  String? day;
  DateTime? start;
  DateTime? end;
  String? duration;

  WorkTime({
    this.day,
    this.start,
    this.end,
    this.duration,
  });
  factory WorkTime.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeFromJson(json);
  Map<String, dynamic> toJson() => _$WorkTimeToJson(this);
}

@JsonSerializable()
class WorkTimes {
  List<WorkTime>? workTimes;

  WorkTimes({this.workTimes});
  factory WorkTimes.fromJson(List<dynamic> json) => _$WorkTimesFromJson(json);
}

@JsonSerializable()
class DoctorsList {
  List<Doctor>? doctors;

  DoctorsList({this.doctors});
  factory DoctorsList.fromJson(List<dynamic> json) =>
      _$DoctorsListFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorsListToJson(this);
}
 // buid runner build
// flutter pub run build_runner build