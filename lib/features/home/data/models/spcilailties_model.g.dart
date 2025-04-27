// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spcilailties_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpcilailtiesModel _$SpcilailtiesModelFromJson(Map<String, dynamic> json) =>
    SpcilailtiesModel(
      specialty: json['specialty'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$SpcilailtiesModelToJson(SpcilailtiesModel instance) =>
    <String, dynamic>{
      'specialty': instance.specialty,
      'image': instance.image,
    };

SpcilailtiesList _$SpcilailtiesListFromJson(List<Map<String, dynamic>> json) =>
    SpcilailtiesList(
      spcilailties: json.map((e) => SpcilailtiesModel.fromJson(e)).toList(),
    );

Map<String, dynamic> _$SpcilailtiesListToJson(SpcilailtiesList instance) =>
    <String, dynamic>{
      'spcilailties': instance.spcilailties,
    };
