import 'package:json_annotation/json_annotation.dart';

part 'find_medicine.g.dart';

@JsonSerializable()
class FindMedicineModel {
  final String name;
  final String notes;
  final String? image;
  final String? answer;
  final bool isFound;
  @JsonKey(name: 'pharmacy_id')
  final String? pharmacyId;
  @JsonKey(name: 'user_id')
  final String userId;

  FindMedicineModel({
    required this.name,
    required this.notes,
    this.image,
    this.answer,
    required this.isFound,
    this.pharmacyId,
    required this.userId,
  });
  factory FindMedicineModel.fromJson(Map<String, dynamic> json) =>
      _$FindMedicineModelFromJson(json);

  Map<String, dynamic> toJson() => _$FindMedicineModelToJson(this);
}
