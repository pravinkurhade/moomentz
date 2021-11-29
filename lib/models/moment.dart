import 'package:json_annotation/json_annotation.dart';

part 'moment.g.dart';

@JsonSerializable()
class Moment {
  Moment({
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

  factory Moment.fromJson(Map<String, dynamic> json) => _$MomentFromJson(json);

  Map<String, dynamic> toJson() => _$MomentToJson(this);
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
