import 'package:json_annotation/json_annotation.dart';

part 'signin_request.g.dart';

@JsonSerializable()
class SignInRequest {
  SignInRequest({
    required this.id,
    required this.DpLink,
    required this.fcm_token,
    required this.device_id,
    required this.mobile_num,
    required this.name,
  });

  @JsonKey(name: '_id')
  String id;
  String DpLink;
  String fcm_token;
  String device_id;
  String mobile_num;
  String name;

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}
