import 'package:json_annotation/json_annotation.dart';
import 'package:medical_system/core/models/user.dart';

part 'reviews.g.dart';

@JsonSerializable()
class Review {
  int id;
  @JsonKey(name: 'doctor_id')
  String doctorId;
  @JsonKey(name: 'user_id')
  String userId;
  String review;
  double rate;
  @JsonKey(name: 'created_at')
  DateTime date;
  @JsonKey(name: 'Users')
  UserModel user;

  Review({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.review,
    required this.rate,
    required this.date,
    required this.user,
  });
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class Reviews {
  List<Review>? reviews;

  Reviews({
    required this.reviews,
  });
  factory Reviews.fromJson(List<Map<String, dynamic>> json) =>
      _$ReviewsFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}

// build runner command
// flutter pub run build_runner build --delete-conflicting-outputs
