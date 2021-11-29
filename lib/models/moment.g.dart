// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Moment _$MomentFromJson(Map<String, dynamic> json) {
  return Moment(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    category: json['category'],
    banner: json['banner'],
    host_id: json['host_id'],
    address: json['address'],
    start_time: json['start_time'],
    duration: json['duration'],
    created_on: json['created_on'],
    images: json['images'],
    tags: json['tags'],
    location: LocationData.fromJson(json['location'] as Map<String, dynamic>),
    announcements: json['announcements'],
    reviews: json['reviews'],
  );
}

Map<String, dynamic> _$MomentToJson(Moment instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'banner': instance.banner,
      'host_id': instance.host_id,
      'address': instance.address,
      'start_time': instance.start_time,
      'duration': instance.duration,
      'created_on': instance.created_on,
      'images': instance.images,
      'tags': instance.tags,
      'location': instance.location,
      'announcements': instance.announcements,
      'reviews': instance.reviews,
    };

LocationData _$LocationDataFromJson(Map<String, dynamic> json) {
  return LocationData(
    type: json['type'],
    coordinates: (json['coordinates'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
  );
}

Map<String, dynamic> _$LocationDataToJson(LocationData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
