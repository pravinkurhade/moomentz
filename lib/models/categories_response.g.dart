// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) {
  return CategoriesResponse(
    categories: (json['categories'] as List<dynamic>)
        .map((e) => CategoriesData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };

CategoriesData _$CategoriesDataFromJson(Map<String, dynamic> json) {
  return CategoriesData(
    name: json['name'],
    id: json['id'],
    url: json['url'],
  );
}

Map<String, dynamic> _$CategoriesDataToJson(CategoriesData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'url': instance.url,
    };
