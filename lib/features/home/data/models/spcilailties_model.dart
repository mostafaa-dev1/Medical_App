import 'package:json_annotation/json_annotation.dart';

part 'spcilailties_model.g.dart';

@JsonSerializable()
class SpcilailtiesModel {
  String? specialty;
  String? image;

  SpcilailtiesModel({this.specialty, this.image});

  factory SpcilailtiesModel.fromJson(Map<String, dynamic> json) =>
      _$SpcilailtiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpcilailtiesModelToJson(this);
}

@JsonSerializable()
class SpcilailtiesList {
  List<SpcilailtiesModel>? spcilailties;

  SpcilailtiesList({this.spcilailties});
  factory SpcilailtiesList.fromJson(List<Map<String, dynamic>> json) =>
      _$SpcilailtiesListFromJson(json);

  Map<String, dynamic> toJson() => _$SpcilailtiesListToJson(this);
}
// build runner
// flutter pub run build_runner build --delete-conflicting-outputs
