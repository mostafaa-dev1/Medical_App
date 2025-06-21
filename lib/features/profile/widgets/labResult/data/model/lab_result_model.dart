import 'package:json_annotation/json_annotation.dart';
import 'package:medical_system/features/laboratories/data/model/labs_model.dart';

part 'lab_result_model.g.dart';

@JsonSerializable()
class LabResultModel {
  final int id;
  final String? result;
  final String? userId;
  final int labId;
  final DateTime date;
  LabsInfo? labModel;

  LabResultModel({
    required this.id,
    required this.result,
    required this.userId,
    required this.labId,
    required this.date,
    this.labModel,
  });

  factory LabResultModel.fromJson(Map<String, dynamic> json) =>
      _$LabResultModelFromJson(json);
}
