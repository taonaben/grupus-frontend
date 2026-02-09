import 'package:json_annotation/json_annotation.dart';

part 'user_create_model.g.dart';

@JsonSerializable()
class UserCreateModel {
  final String username;
  final String email;
  final String password;
  final String password2;
  final String? first_name;
  final String? last_name;
  final String? bio;
  final String? profile_picture;
  final String? preferred_language;
  final String? notification_settings;

  UserCreateModel({
    required this.username,
    required this.email,
    required this.password,
    required this.password2,
    this.first_name,
    this.last_name,
    this.bio,
    this.profile_picture,
    this.preferred_language,
    this.notification_settings,
  });

  factory UserCreateModel.fromJson(Map<String, dynamic> json) =>
      _$UserCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreateModelToJson(this);
}
