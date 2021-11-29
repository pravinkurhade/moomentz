// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moments_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentsResponse _$MomentsResponseFromJson(Map<String, dynamic> json) {
  return MomentsResponse(
    feed: (json['feed'] as List<dynamic>)
        .map((e) => Moment.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MomentsResponseToJson(MomentsResponse instance) =>
    <String, dynamic>{
      'feed': instance.feed,
    };
