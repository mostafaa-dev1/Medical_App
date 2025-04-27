// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      id: json['id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String? ?? '',
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
      uid: json['uid'] as String?,
      specialty: json['specialty'] as String?,
      address: (json['address'] as List<dynamic>?)
              ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      clinic: (json['Clinics'] as List<dynamic>?)
          ?.map((e) => Clinic.fromJson(e as Map<String, dynamic>))
          .toList(),
      doctorInfo: json['DoctorsInfo'] == null
          ? null
          : DoctorInfo.fromJson(json['DoctorsInfo'] as Map<String, dynamic>),
      firstNameAr: json['first_name_ar'] as String?,
      lastNameAr: json['last_name_ar'] as String?,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'first_name_ar': instance.firstNameAr,
      'last_name_ar': instance.lastNameAr,
      'email': instance.email,
      'image': instance.image,
      'phone': instance.phone,
      'gender': instance.gender,
      'uid': instance.uid,
      'specialty': instance.specialty,
      'address': instance.address,
      'Clinics': instance.clinic,
      'DoctorsInfo': instance.doctorInfo,
    };

DoctorInfo _$DoctorInfoFromJson(Map<String, dynamic> json) => DoctorInfo(
      id: json['id'] as String?,
      about: json['about'] as String?,
      aboutAr: json['about_ar'] as String?,
      experience: json['experience'] as List<dynamic>?,
      experienceAr: json['experience_ar'] as List<dynamic>?,
      education: json['education'] as List<dynamic>?,
      educationAr: json['education_ar'] as List<dynamic>?,
      specialities: json['specialities'] as List<dynamic>?,
      specialitiesAr: json['specialities_ar'] as List<dynamic>?,
      dateOfBirth: json['date_of_birth'] as String?,
      patients: json['patients'] as int? ?? 0,
    );

Map<String, dynamic> _$DoctorInfoToJson(DoctorInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'about': instance.about,
      'about_ar': instance.aboutAr,
      'experience': instance.experience,
      'experience_ar': instance.experienceAr,
      'education': instance.education,
      'education_ar': instance.educationAr,
      'specialities': instance.specialities,
      'specialities_ar': instance.specialitiesAr,
      'date_of_birth': instance.dateOfBirth,
    };

Clinic _$ClinicFromJson(Map<String, dynamic> json) => Clinic(
      id: json['id'] as String?,
      doctorId: json['doctor_id'] as String?,
      latLong: json['latLong'] as List<dynamic>?,
      lattitude: (json['lattitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      government: json['government'] as String?,
      city: json['city'] as String?,
      street: json['street'] as String?,
      phones:
          (json['phones'] as List<dynamic>?)?.map((e) => e as String).toList(),
      services: json['services'] as List<dynamic>?,
      workTimes: json['work_times'] == null
          ? null
          : WorkTimes.fromJson(json['work_times'] as List<dynamic>),
      doctor: json['Doctors'] == null
          ? null
          : Doctor.fromJson(json['Doctors'] as Map<String, dynamic>),
      doctorInfo: json['DoctorsInfo'] == null
          ? null
          : DoctorInfo.fromJson(json['DoctorsInfo'] as Map<String, dynamic>),
      fee: (json['fee'] as num?)?.toInt() ?? 0,
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      rateCount: (json['rate_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ClinicToJson(Clinic instance) => <String, dynamic>{
      'id': instance.id,
      'doctor_id': instance.doctorId,
      'latLong': instance.latLong,
      'lattitude': instance.lattitude,
      'longitude': instance.longitude,
      'government': instance.government,
      'city': instance.city,
      'fee': instance.fee,
      'rate': instance.rate,
      'rate_count': instance.rateCount,
      'street': instance.street,
      'phones': instance.phones,
      'services': instance.services,
      'work_times': instance.workTimes,
      'Doctors': instance.doctor,
      'DoctorsInfo': instance.doctorInfo,
    };

Clinics _$ClinicsFromJson(List<dynamic> json) => Clinics(
      clinics: json.map((e) => Clinic.fromJson(e)).toList(),
    );

Map<String, dynamic> _$ClinicsToJson(Clinics instance) => <String, dynamic>{
      'clinics': instance.clinics,
    };

WorkTime _$WorkTimeFromJson(Map<String, dynamic> json) => WorkTime(
      day: json['day'] as String?,
      start: json['start'] == null ? null : parseTime(json['start'] as String),
      end: json['end'] == null ? null : parseTime(json['end'] as String),
      duration: json['duration'] as String?,
    );

Map<String, dynamic> _$WorkTimeToJson(WorkTime instance) => <String, dynamic>{
      'day': instance.day,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'duration': instance.duration,
    };
DateTime parseTime(String time) {
  String hour = time.split(':')[0];
  String minute = time.split(':')[1];
  DateTime dateTime = DateTime(0, 0, 0, int.parse(hour), int.parse(minute));
  return dateTime;
}

WorkTimes _$WorkTimesFromJson(List<dynamic> json) => WorkTimes(
      workTimes: json.map((e) => WorkTime.fromJson(e)).toList(),
    );

Map<String, dynamic> _$WorkTimesToJson(WorkTimes instance) => <String, dynamic>{
      'workTimes': instance.workTimes,
    };

DoctorsList _$DoctorsListFromJson(List<dynamic> json) => DoctorsList(
      doctors: json.map((e) => Doctor.fromJson(e)).toList(),
    );

Map<String, dynamic> _$DoctorsListToJson(DoctorsList instance) =>
    <String, dynamic>{
      'doctors': instance.doctors,
    };
