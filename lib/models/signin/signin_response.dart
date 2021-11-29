import 'package:json_annotation/json_annotation.dart';

part 'signin_response.g.dart';

@JsonSerializable()
class SignInResponse {
  SignInResponse({
    this.id,
  });

  dynamic id;

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    return _$SignInResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}
