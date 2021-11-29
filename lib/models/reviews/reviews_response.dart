import 'package:json_annotation/json_annotation.dart';

part 'reviews_response.g.dart';

@JsonSerializable()
class ReviewsResponse {
  ReviewsResponse({
    required this.reviews,
  });
  List<ReviewsData> reviews;

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsResponseToJson(this);
}

@JsonSerializable()
class ReviewsData {
  ReviewsData({
    this.id,
    this.message,
    this.reviewer_id,
    this.created_on,
  });

  dynamic id;
  dynamic message;
  dynamic reviewer_id;
  dynamic created_on;

  factory ReviewsData.fromJson(Map<String, dynamic> json) =>
      _$ReviewsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsDataToJson(this);
}
