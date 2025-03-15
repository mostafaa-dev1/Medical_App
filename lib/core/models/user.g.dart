// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      phone: json['phone'] as String,
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      gender: json['gender'] as String,
      uid: json['uid'] as String,
      adresses: (json['address'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'image': instance.image,
      'phone': instance.phone,
      'date_of_birth': instance.dateOfBirth.toIso8601String(),
      'gender': instance.gender,
      'address': instance.adresses,
    };
