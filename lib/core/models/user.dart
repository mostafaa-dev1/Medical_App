import 'package:json_annotation/json_annotation.dart';
import 'package:medical_system/core/models/address.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(defaultValue: 'PAT-0')
  String? id;
  @JsonKey(defaultValue: '')
  String? uid;
  @JsonKey(name: 'first_name', defaultValue: '')
  String? firstName;
  @JsonValue('')
  @JsonKey(name: 'last_name', defaultValue: '')
  String? lastName;
  @JsonKey(defaultValue: '')
  String? email;
  @JsonKey(defaultValue: '')
  String? image;
  @JsonKey(defaultValue: '')
  String? phone;
  String? messageToken;
  @JsonKey(
    name: 'date_of_birth',
  )
  DateTime? dateOfBirth;
  @JsonKey(defaultValue: '')
  String? gender;
  @JsonKey(defaultValue: [])
  List<Address>? addresses;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.uid,
    this.addresses,
    this.messageToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? image,
    String? phone,
    DateTime? dateOfBirth,
    String? gender,
    String? uid,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: name ?? firstName,
      lastName: name ?? lastName,
      email: email ?? this.email,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      uid: uid ?? this.uid,
      addresses: addresses,
    );
  }
}
