// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsResponse _$ReviewsResponseFromJson(Map<String, dynamic> json) {
  return ReviewsResponse(
    reviews: (json['reviews'] as List<dynamic>)
        .map((e) => ReviewsData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ReviewsResponseToJson(ReviewsResponse instance) =>
    <String, dynamic>{
      'reviews': instance.reviews,
    };

ReviewsData _$ReviewsDataFromJson(Map<String, dynamic> json) {
  return ReviewsData(
    id: json['id'],
    message: json['message'],
    reviewer_id: json['reviewer_id'],
    created_on: json['created_on'],
  );
}

Map<String, dynamic> _$ReviewsDataToJson(ReviewsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'reviewer_id': instance.reviewer_id,
      'created_on': instance.created_on,
    };
