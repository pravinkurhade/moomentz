// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequest _$SignInRequestFromJson(Map<String, dynamic> json) {
  return SignInRequest(
    id: json['_id'] as String,
    DpLink: json['DpLink'] as String,
    fcm_token: json['fcm_token'] as String,
    device_id: json['device_id'] as String,
    mobile_num: json['mobile_num'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$SignInRequestToJson(SignInRequest instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'DpLink': instance.DpLink,
      'fcm_token': instance.fcm_token,
      'device_id': instance.device_id,
      'mobile_num': instance.mobile_num,
      'name': instance.name,
    };
