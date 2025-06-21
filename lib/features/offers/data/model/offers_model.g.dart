// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersModel _$OffersModelFromJson(Map<String, dynamic> json) => OffersModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      descriptionAr: json['description_ar'] as String,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      offerType: json['offer_type'] as String?,
      price: (json['price'] as num?)?.toInt(),
      discountPercentage: (json['discount_percentage'] as num?)?.toInt(),
      originalPrice: (json['original_price'] as num?)?.toInt(),
      usageLimit: (json['usage_limit'] as num).toInt(),
      doctor: json['Doctors'] == null
          ? null
          : Doctor.fromJson(json['Doctors'] as Map<String, dynamic>),
      provider: json['provider'] as String,
      lab: json['LaboratoriesInfo'] == null
          ? null
          : LabsInfo.fromJson(json['LaboratoriesInfo'] as Map<String, dynamic>),
      hospital: json['HospitalsInfo'] == null
          ? null
          : ClinicInfo.fromJson(json['HospitalsInfo'] as Map<String, dynamic>),
      clinic: json['Clinics'] == null
          ? null
          : Clinic.fromJson(json['Clinics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OffersModelToJson(OffersModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'images': instance.images,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'offer_type': instance.offerType,
      'price': instance.price,
      'discount_percentage': instance.discountPercentage,
      'original_price': instance.originalPrice,
      'usage_limit': instance.usageLimit,
      'Doctors': instance.doctor,
      'provider': instance.provider,
    };

OffersList _$OffersListFromJson(List<Map<String, dynamic>> json) => OffersList(
      offers: json.map((e) => OffersModel.fromJson(e)).toList(),
    );

Map<String, dynamic> _$OffersListToJson(OffersList instance) =>
    <String, dynamic>{
      'offers': instance.offers,
    };
