// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClinicModel _$ClinicModelFromJson(Map<String, dynamic> json) => ClinicModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      nameAr: json['name_ar'] as String,
      image: json['image'] as String,
      description: json['description'] as String?,
      descriptionAr: json['description_ar'] as String?,
    );

Map<String, dynamic> _$ClinicModelToJson(ClinicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_ar': instance.nameAr,
      'image': instance.image,
      'description': instance.description,
      'description_ar': instance.descriptionAr,
    };

ClinicInfo _$ClinicInfoFromJson(Map<String, dynamic> json) => ClinicInfo(
      id: (json['id'] as num).toInt(),
      location: json['location'] as Map<String, dynamic>,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      phones:
          (json['phones'] as List<dynamic>).map((e) => e as String).toList(),
      services:
          (json['services'] as List<dynamic>).map((e) => e as String).toList(),
      government: json['government'] as String,
      city: json['city'] as String,
      clinic: ClinicModel.fromJson(json['Hospitals'] as Map<String, dynamic>),
      rate: json['rate'] as double,
      rateCount: json['rate_count'] as int,
    );

Map<String, dynamic> _$ClinicInfoToJson(ClinicInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'address': instance.address,
      'phones': instance.phones,
      'services': instance.services,
      'government': instance.government,
      'city': instance.city,
    };
