// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabModel _$LabModelFromJson(Map<String, dynamic> json) => LabModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameAr: json['name_ar'] as String?,
      description: json['description'] as String?,
      descriptionAr: json['description_ar'] as String?,
      image: json['image'] as String?,
      specialty: json['specialty'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      rateCount: (json['rate_count'] as num?)?.toInt(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      patients: (json['patients'] as num?)?.toInt(),
      labsInfo: (json['LaboratoriesInfo'] as List<dynamic>?)
          ?.map((e) => LabsInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LabModelToJson(LabModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_ar': instance.nameAr,
      'description': instance.description,
      'description_ar': instance.descriptionAr,
      'image': instance.image,
      'specialty': instance.specialty,
      'rate': instance.rate,
      'rate_count': instance.rateCount,
      'services': instance.services,
      'patients': instance.patients,
      'LaboratoriesInfo': instance.labsInfo,
    };

LabsInfo _$LabsInfoFromJson(Map<String, dynamic> json) => LabsInfo(
      id: (json['id'] as num?)?.toInt(),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      phones:
          (json['phones'] as List<dynamic>?)?.map((e) => e as String).toList(),
      location: json['location'] as Map<String, dynamic>?,
      government: json['government'] as String?,
      city: json['city'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      workTimes: json['work_times'] == null
          ? null
          : WorkTimes.fromJson(json['work_times'] as List<dynamic>),
      lab: json['Laboratories'] == null
          ? null
          : LabModel.fromJson(json['Laboratories'] as Map<String, dynamic>),
      services: json['services'] == null
          ? null
          : (json['services'] as List<dynamic>)
              .map((e) => LabServices.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$LabsInfoToJson(LabsInfo instance) => <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'phones': instance.phones,
      'location': instance.location,
      'government': instance.government,
      'city': instance.city,
      'images': instance.images,
      'work_times': instance.workTimes,
      'lab': instance.lab,
    };

LabWorkTime _$LabWorkTimeFromJson(Map<String, dynamic> json) => LabWorkTime(
      day: json['from'] as String?,
      duartion: json['to'] as String?,
      start: json['start'] == null ? null : parseTime(json['start'] as String),
      end: json['end'] == null ? null : parseTime(json['end'] as String),
    );
DateTime parseTime(String time) {
  final parts = time.split(':');
  final hours = int.parse(parts[0]);
  final minutes = int.parse(parts[1]);

  final dateTime = DateTime(
    0,
    0,
    0,
    hours,
    minutes,
  );
  return dateTime;
}

Map<String, dynamic> _$LabWorkTimeToJson(LabWorkTime instance) =>
    <String, dynamic>{
      'from': instance.day,
      'to': instance.duartion,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      streat: json['streat'] as String? ?? '',
      streatAr: json['streat_ar'] as String? ?? '',
      sign: json['sign'] as String? ?? '',
      signAr: json['sign_ar'] as String? ?? '',
      building: json['building'] as String? ?? '',
      buildingAr: json['building_ar'] as String? ?? '',
      floor: json['floor'] as String? ?? '',
      floorAr: json['floor_ar'] as String? ?? '',
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'streat': instance.streat,
      'streat_ar': instance.streatAr,
      'sign': instance.sign,
      'sign_ar': instance.signAr,
      'building': instance.building,
      'building_ar': instance.buildingAr,
      'floor': instance.floor,
      'floor_ar': instance.floorAr,
    };

LabServices _$LabServicesFromJson(Map<String, dynamic> json) => LabServices(
      service: json['service'] as String,
      serviceAr: json['service_ar'] as String,
      price: json['price'] as String,
    );

Map<String, dynamic> _$LabServicesToJson(LabServices instance) =>
    <String, dynamic>{
      'service': instance.service,
      'service_ar': instance.serviceAr,
      'price': instance.price,
    };
