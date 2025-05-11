import 'package:json_annotation/json_annotation.dart';

part 'notifications_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime date;
  final String type;
  final String content;
  @JsonKey(name: 'content_ar')
  final String contentAr;
  @JsonKey(name: 'read')
  bool isRead;

  NotificationModel({
    required this.id,
    required this.date,
    required this.type,
    required this.content,
    required this.contentAr,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
