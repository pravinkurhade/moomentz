import 'package:json_annotation/json_annotation.dart';
import '../moment.dart';

part 'moments_response.g.dart';

@JsonSerializable()
class MomentsResponse {
  MomentsResponse({
    required this.feed,
  });

  List<Moment> feed;

  factory MomentsResponse.fromJson(Map<String, dynamic> json) =>
      _$MomentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MomentsResponseToJson(this);
}
