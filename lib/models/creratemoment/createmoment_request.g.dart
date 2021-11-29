// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createmoment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMoment _$CreateMomentFromJson(Map<String, dynamic> json) {
  return CreateMoment(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    banner: json['banner'] as String,
    host_id: json['host_id'] as String,
    address: json['address'] as String,
    start_time: json['start_time'] as int,
    duration: json['duration'] as int,
    invite_accept_auth: json['invite_accept_auth'] as String,
    invites: json['invites'] as int,
    images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    tags: json['tags'] as List<dynamic>,
    location: LocationData.fromJson(json['location'] as Map<String, dynamic>),
    announcements: json['announcements'] as List<dynamic>,
    reviews: json['reviews'] as List<dynamic>,
  );
}

Map<String, dynamic> _$CreateMomentToJson(CreateMoment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'banner': instance.banner,
      'host_id': instance.host_id,
      'address': instance.address,
      'start_time': instance.start_time,
      'duration': instance.duration,
      'invite_accept_auth': instance.invite_accept_auth,
      'invites': instance.invites,
      'images': instance.images,
      'tags': instance.tags,
      'location': instance.location,
      'announcements': instance.announcements,
      'reviews': instance.reviews,
    };
