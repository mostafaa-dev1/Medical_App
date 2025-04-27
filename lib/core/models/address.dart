import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String? id;
  dynamic latitude;
  dynamic longitude;
  String? city;
  String? country;
  String? street;

  Address({
    this.id,
    this.latitude,
    this.longitude,
    this.city,
    this.country,
    this.street,
  });
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
