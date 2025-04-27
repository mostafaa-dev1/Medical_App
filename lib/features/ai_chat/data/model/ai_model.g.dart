// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiModel _$AiModelFromJson(Map<String, dynamic> json) => AiModel(
      message: json['message'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$AiModelToJson(AiModel instance) => <String, dynamic>{
      'message': instance.message,
      'role': instance.role,
    };

AiMessages _$AiMessagesFromJson(Map<String, dynamic> json) => AiMessages(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => AiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AiMessagesToJson(AiMessages instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };
