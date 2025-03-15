import 'package:json_annotation/json_annotation.dart';
import 'package:medical_system/core/models/address.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  final String uid;
  String firstName;
  String lastName;
  final String email;
  String image;
  String phone;
  DateTime dateOfBirth;
  String gender;
  List<Address> adresses;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    required this.uid,
    required this.adresses,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
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
      firstName: name ?? firstName,
      lastName: name ?? lastName,
      email: email ?? this.email,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      uid: uid ?? this.uid,
      adresses: adresses,
    );
  }
}
