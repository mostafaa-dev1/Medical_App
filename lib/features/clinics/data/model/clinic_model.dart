import 'package:json_annotation/json_annotation.dart';
import 'package:medical_system/features/laboratories/data/model/labs_model.dart';

part 'clinic_model.g.dart';

@JsonSerializable()
class ClinicModel {
  final int id;
  final String name;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  final String image;
  String? description;
  @JsonKey(name: 'description_ar')
  String? descriptionAr;

  ClinicModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.image,
    this.description,
    this.descriptionAr,
  });
  factory ClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicModelToJson(this);
}

@JsonSerializable()
class ClinicInfo {
  final int id;
  Map<String, dynamic> location;
  final Address address;
  List<String> phones;
  List<String> services;
  final String government;
  final String city;
  double? rate;
  @JsonKey(name: 'rate_count')
  int? rateCount;
  ClinicModel? clinic;

  ClinicInfo({
    required this.id,
    required this.location,
    required this.address,
    required this.phones,
    required this.services,
    required this.government,
    required this.city,
    this.clinic,
    this.rate,
    this.rateCount,
  });
  factory ClinicInfo.fromJson(Map<String, dynamic> json) =>
      _$ClinicInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicInfoToJson(this);
}

// build_runner command
// flutter pub run build_runner build --delete-conflicting-outputs
