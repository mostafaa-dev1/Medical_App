// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: (json['id'] as num).toInt(),
      doctorId: json['doctor_id'] as String,
      userId: json['user_id'] as String,
      review: json['review'] as String,
      rate: (json['rate'] as num).toDouble(),
      date: DateTime.parse(json['created_at'] as String),
      user: UserModel.fromJson(json['Users'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'doctor_id': instance.doctorId,
      'user_id': instance.userId,
      'review': instance.review,
      'rate': instance.rate,
      'created_at': instance.date.toIso8601String(),
      'Users': instance.user,
    };

Reviews _$ReviewsFromJson(List<Map<String, dynamic>> json) => Reviews(
      reviews: json.map((e) => Review.fromJson(e)).toList(),
    );

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'reviews': instance.reviews,
    };
