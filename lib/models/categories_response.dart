import 'package:json_annotation/json_annotation.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  CategoriesResponse({
    required this.categories,
  });

  List<CategoriesData> categories;

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}

@JsonSerializable()
class CategoriesData {
  CategoriesData({
    this.name,
    this.id,
    this.url,
  });

  dynamic name;
  dynamic id;
  dynamic url;

  factory CategoriesData.fromJson(Map<String, dynamic> json) =>
      _$CategoriesDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesDataToJson(this);
}
