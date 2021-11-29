import 'package:json_annotation/json_annotation.dart';

part 'join_response.g.dart';

@JsonSerializable()
class JoinResponse {
  JoinResponse({
    this.status,
  });

  dynamic status;

  factory JoinResponse.fromJson(Map<String, dynamic> json) =>
      _$JoinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$JoinResponseToJson(this);
}
