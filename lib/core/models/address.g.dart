// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      street: json['street'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
      'country': instance.country,
      'street': instance.street,
    };
