import 'package:json_annotation/json_annotation.dart';

part 'user_create_model.g.dart';

@JsonSerializable()
class UserCreateModel {
  final String username;
  final String email;

  final String password;
  final String password2;

  @JsonKey(name: "is_email_verified")
  final bool? isEmailVerified;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? bio;

  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  @JsonKey(name: 'preferred_language')
  final String? preferredLanguage;
  @JsonKey(name: 'notification_settings')
  final String? notificationSettings;

  UserCreateModel({
    required this.username,
    required this.email,
    required this.password,
    required this.password2,
    this.isEmailVerified,
    this.firstName,
    this.lastName,
    this.bio,
    this.profilePicture,
    this.preferredLanguage,
    this.notificationSettings,
  });

  factory UserCreateModel.fromJson(Map<String, dynamic> json) =>
      _$UserCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreateModelToJson(this);
}
