// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    id: json['id'] as int,
    date: DateTime.parse(json['created_at'] as String),
    type: json['type'] as String,
    content: json['content'] as String,
    contentAr: json['content_ar'] as String,
    isRead: json['read'] as bool,
  );
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.date,
      'type': instance.type,
      'body': instance.content,
      'body_ar': instance.contentAr,
      'read': instance.isRead,
    };
