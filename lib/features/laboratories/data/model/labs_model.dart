import 'package:json_annotation/json_annotation.dart';
import 'package:medical_system/core/models/doctor_model.dart';

part 'labs_model.g.dart';

@JsonSerializable()
class LabModel {
  int? id;
  String? name;
  @JsonKey(name: 'name_ar')
  String? nameAr;
  String? description;
  @JsonKey(name: 'description_ar')
  String? descriptionAr;
  String? image;
  String? specialty;
  double? rate;
  @JsonKey(name: 'rate_count')
  int? rateCount;
  List<String>? services;
  int? patients;
  @JsonKey(name: 'LaboratoriesInfo')
  List<LabsInfo>? labsInfo;

  LabModel({
    this.id,
    this.name,
    this.nameAr,
    this.description,
    this.descriptionAr,
    this.image,
    this.specialty,
    this.rate,
    this.rateCount,
    this.services,
    this.patients,
    this.labsInfo,
  });

  factory LabModel.fromJson(Map<String, dynamic> json) =>
      _$LabModelFromJson(json);

  Map<String, dynamic> toJson() => _$LabModelToJson(this);
}

// @JsonSerializable()
// class Labs {
//   List<LabModel>? labs;

//   Labs({this.labs});
//   factory Labs.fromJson(List<dynamic> json) => _$LabsFromJson(json);
// }

@JsonSerializable()
class LabsInfo {
  int? id;
  Address? address;
  List<String>? phones;
  Map<String, dynamic>? location;
  String? government;
  String? city;
  List<String>? images;
  @JsonKey(name: 'work_times')
  WorkTimes? workTimes;
  @JsonKey(name: 'Loboratories')
  LabModel? lab;
  List<LabServices>? services;
  int? fee;

  LabsInfo({
    this.id,
    this.address,
    this.phones,
    this.location,
    this.government,
    this.city,
    this.images,
    this.workTimes,
    this.lab,
    this.services,
    this.fee,
  });
  factory LabsInfo.fromJson(Map<String, dynamic> json) =>
      _$LabsInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LabsInfoToJson(this);
}

@JsonSerializable()
class LabWorkTime {
  String? day;
  DateTime? start;
  DateTime? end;
  String? duartion;

  LabWorkTime({this.duartion, this.day, this.start, this.end});
  factory LabWorkTime.fromJson(Map<String, dynamic> json) =>
      _$LabWorkTimeFromJson(json);
}

@JsonSerializable()
class Address {
  String? streat;
  @JsonKey(name: 'streat_ar')
  String? streatAr;
  String? sign;
  @JsonKey(name: 'sign_ar')
  String? signAr;
  String? building;
  @JsonKey(name: 'building_ar')
  String? buildingAr;
  String? floor;
  @JsonKey(name: 'floor_ar')
  String? floorAr;

  Address({
    this.streat,
    this.streatAr,
    this.sign,
    this.signAr,
    this.building,
    this.buildingAr,
    this.floor,
    this.floorAr,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@JsonSerializable()
class LabServices {
  String service;
  @JsonKey(name: 'service_ar')
  String serviceAr;
  String price;

  LabServices({
    required this.service,
    required this.serviceAr,
    required this.price,
  });
  factory LabServices.fromJson(Map<String, dynamic> json) =>
      _$LabServicesFromJson(json);
  Map<String, dynamic> toJson() => _$LabServicesToJson(this);
}
// build runner command
// flutter pub run build_runner build --delete-conflicting-outputs
