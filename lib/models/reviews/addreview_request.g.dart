// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addreview_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReviewRequest _$AddReviewRequestFromJson(Map<String, dynamic> json) {
  return AddReviewRequest(
    message: json['message'],
    reviewer_id: json['reviewer_id'],
  );
}

Map<String, dynamic> _$AddReviewRequestToJson(AddReviewRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'reviewer_id': instance.reviewer_id,
    };
