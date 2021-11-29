import 'package:json_annotation/json_annotation.dart';

part 'createmoment_response.g.dart';

@JsonSerializable()
class CreateMomentResponse {
  CreateMomentResponse({
    required this.id,
  });

  String id;

  factory CreateMomentResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    return _$CreateMomentResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateMomentResponseToJson(this);
}
