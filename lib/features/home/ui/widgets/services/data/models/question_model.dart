import 'package:json_annotation/json_annotation.dart';
import 'package:medical_system/core/models/doctor_model.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  final int? id;
  final String question;
  @JsonKey(name: 'question_details')
  final String questionDetails;
  final String? answer;
  @JsonKey(name: 'doctor_id')
  final String? doctorId;
  @JsonKey(name: 'user_id')
  final String userId;
  final String speciality;
  final int age;
  final String gender;
  @JsonKey(name: 'created_at')
  final DateTime? date;
  final bool answered;
  Doctor? doctor;

  QuestionModel({
    this.id,
    required this.questionDetails,
    required this.question,
    this.answer,
    this.doctorId,
    required this.userId,
    required this.speciality,
    required this.age,
    required this.gender,
    this.date,
    required this.answered,
    this.doctor,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
