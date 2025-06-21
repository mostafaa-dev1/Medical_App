part of 'lab_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabResultModel _$LabResultModelFromJson(Map<String, dynamic> json) {
  return LabResultModel(
    id: json['id'] as int,
    date: DateTime.parse(json['created_at'] as String),
    result: json['file_url'] as String?,
    labId: json['lab_id'],
    userId: json['user_id'] as String?,
    labModel: json['LaboratoriesInfo'] == null
        ? null
        : LabsInfo.fromJson(json['LaboratoriesInfo'] as Map<String, dynamic>),
  );
}
