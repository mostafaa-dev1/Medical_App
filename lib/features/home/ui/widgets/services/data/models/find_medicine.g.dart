// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindMedicineModel _$FindMedicineModelFromJson(Map<String, dynamic> json) =>
    FindMedicineModel(
      name: json['name'] as String,
      notes: json['notes'] as String,
      image: json['image'] as String?,
      answer: json['answer'] as String?,
      isFound: json['isFound'] as bool,
      pharmacyId: json['pharmacy_id'] as String?,
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$FindMedicineModelToJson(FindMedicineModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'notes': instance.notes,
      'image': instance.image,
      'answer': instance.answer,
      'isFound': instance.isFound,
      'pharmacy_id': instance.pharmacyId,
      'user_id': instance.userId,
    };
