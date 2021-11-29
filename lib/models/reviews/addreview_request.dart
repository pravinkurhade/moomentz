import 'package:json_annotation/json_annotation.dart';

part 'addreview_request.g.dart';

@JsonSerializable()
class AddReviewRequest {
  AddReviewRequest({
    this.message,
    this.reviewer_id,
  });
  dynamic message;
  dynamic reviewer_id;

  factory AddReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$AddReviewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddReviewRequestToJson(this);
}
