import 'package:json_annotation/json_annotation.dart';

import '../moment.dart';

part 'createmoment_request.g.dart';

@JsonSerializable()
class CreateMoment {
  CreateMoment({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.banner,
    required this.host_id,
    required this.address,
    required this.start_time,
    required this.duration,
    required this.invite_accept_auth,
    required this.invites,
    required this.images,
    required this.tags,
    required this.location,
    required this.announcements,
    required this.reviews,
  });

  String id;
  String name;
  String description;
  String category;
  String banner;
  String host_id;
  String address;
  int start_time;
  int duration;
  String invite_accept_auth;
  int invites;
  List<String> images;
  List<dynamic> tags;
  LocationData location;
  List<dynamic> announcements;
  List<dynamic> reviews;

  factory CreateMoment.fromJson(Map<String, dynamic> json) {
    print(json);
    return _$CreateMomentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateMomentToJson(this);
}
