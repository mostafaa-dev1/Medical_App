// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: (json['id'] as num?)?.toInt(),
      questionDetails: json['question_details'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String?,
      doctorId: json['doctor_id'] as String?,
      userId: json['user_id'] as String,
      speciality: json['speciality'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      date: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      answered: json['answered'] as bool,
      doctor: json['Doctors'] == null
          ? null
          : Doctor.fromJson(json['Doctors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'question': instance.question,
      'question_details': instance.questionDetails,
      'user_id': instance.userId,
      'speciality': instance.speciality,
      'age': instance.age,
      'gender': instance.gender,
      'answered': instance.answered,
    };
