import 'package:json_annotation/json_annotation.dart';
import 'moment.dart';

part 'my_moments_response.g.dart';

@JsonSerializable()
class MyMomentsResponse {
  MyMomentsResponse({
    required this.moments,
  });

  List<MomentData> moments;

  factory MyMomentsResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    return _$MyMomentsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MyMomentsResponseToJson(this);
}

@JsonSerializable()
class MomentData {
  MomentData({
    this.id,
    this.name,
    this.description,
    this.category,
    this.banner,
    this.host_id,
    this.address,
    this.start_time,
    this.duration,
    this.created_on,
    required this.images,
    required this.tags,
    required this.location,
    this.announcements,
    this.reviews,
  });

  @JsonKey(name: '_id')
  dynamic id;
  dynamic name;
  dynamic description;
  dynamic category;
  dynamic banner;
  dynamic host_id;
  dynamic address;
  dynamic start_time;
  dynamic duration;
  dynamic created_on;
  dynamic images;
  dynamic tags;
  LocationData location;
  dynamic announcements;
  dynamic reviews;

  factory MomentData.fromJson(Map<String, dynamic> json) =>
      _$MomentDataFromJson(json);

  Map<String, dynamic> toJson() => _$MomentDataToJson(this);
}

@JsonSerializable()
class LocationData {
  LocationData({
    this.type,
    required this.coordinates,
  });

  dynamic type;
  List<double> coordinates;

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDataToJson(this);
}
