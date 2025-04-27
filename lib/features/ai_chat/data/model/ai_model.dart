import 'package:json_annotation/json_annotation.dart';

part 'ai_model.g.dart';

@JsonSerializable()
class AiModel {
  String message;
  String role;

  AiModel({
    required this.message,
    required this.role,
  });
  factory AiModel.fromJson(Map<String, dynamic> json) =>
      _$AiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AiModelToJson(this);
}

@JsonSerializable()
class AiMessages {
  List<AiModel> messages;

  AiMessages({
    required this.messages,
  });
  factory AiMessages.fromJson(Map<String, dynamic> json) =>
      _$AiMessagesFromJson(json);

  Map<String, dynamic> toJson() => _$AiMessagesToJson(this);
}

// build runner command
// flutter pub run build_runner build --delete-conflicting-outputs
