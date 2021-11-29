import 'package:json_annotation/json_annotation.dart';

part 'message_request.g.dart';

@JsonSerializable()
class MessageRequest {
  MessageRequest({
    this.Message,
  });
  dynamic Message;

  factory MessageRequest.fromJson(Map<String, dynamic> json) =>
      _$MessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MessageRequestToJson(this);
}
