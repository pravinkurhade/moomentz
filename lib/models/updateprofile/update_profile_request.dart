import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequest {
  UpdateProfileRequest({
    required this.fields,
  });
  Fields fields;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}

@JsonSerializable()
class Fields {
  Fields({
    this.fcm_token,
  });
  dynamic fcm_token;

  factory Fields.fromJson(Map<String, dynamic> json) => _$FieldsFromJson(json);

  Map<String, dynamic> toJson() => _$FieldsToJson(this);
}
