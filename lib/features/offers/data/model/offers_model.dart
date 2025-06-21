import 'package:json_annotation/json_annotation.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/features/clinics/data/model/clinic_model.dart';
import 'package:medical_system/features/laboratories/data/model/labs_model.dart';

part 'offers_model.g.dart';

@JsonSerializable()
class OffersModel {
  int id;
  String title;
  String description;
  String descriptionAr;
  List<String>? images;
  @JsonKey(name: 'start_date')
  DateTime? startDate;
  @JsonKey(name: 'end_date')
  DateTime? endDate;
  @JsonKey(name: 'offer_type')
  String? offerType;
  int? price;
  @JsonKey(name: 'discount_percentage')
  int? discountPercentage;
  @JsonKey(name: 'original_price')
  int? originalPrice;
  @JsonKey(name: 'usage_limit')
  int usageLimit;
  @JsonKey(name: 'Doctors')
  Doctor? doctor;
  String provider;
  Clinic? clinic;
  LabsInfo? lab;
  ClinicInfo? hospital;

  OffersModel({
    required this.descriptionAr,
    required this.id,
    required this.title,
    required this.description,
    this.images,
    this.startDate,
    this.endDate,
    this.offerType,
    this.price,
    this.discountPercentage,
    this.originalPrice,
    required this.usageLimit,
    this.doctor,
    required this.provider,
    this.clinic,
    this.lab,
    this.hospital,
  });
  factory OffersModel.fromJson(Map<String, dynamic> json) =>
      _$OffersModelFromJson(json);
  Map<String, dynamic> toJson() => _$OffersModelToJson(this);
}

@JsonSerializable()
class OffersList {
  List<OffersModel> offers;
  OffersList({required this.offers});
  factory OffersList.fromJson(List<Map<String, dynamic>> json) =>
      _$OffersListFromJson(json);
  Map<String, dynamic> toJson() => _$OffersListToJson(this);
}
