// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(Map<String, dynamic> json) {
  return UpdateProfileRequest(
    fields: Fields.fromJson(json['fields'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateProfileRequestToJson(
        UpdateProfileRequest instance) =>
    <String, dynamic>{
      'fields': instance.fields,
    };

Fields _$FieldsFromJson(Map<String, dynamic> json) {
  return Fields(
    fcm_token: json['fcm_token'],
  );
}

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'fcm_token': instance.fcm_token,
    };
