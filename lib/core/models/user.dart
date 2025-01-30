import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String uid;
  String name;
  final String email;
  String image;
  String phone;
  DateTime dateOfBirth;
  String gender;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    required this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? image,
    String? phone,
    DateTime? dateOfBirth,
    String? gender,
    String? uid,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      uid: uid ?? this.uid,
    );
  }
}
