import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  final String? user;
  final String? first_name;
  final String? last_name;
  final String? bio;
  final String? profile_picture;
  final String? preferred_language;
  final String? notification_settings;

  UserProfile({
    this.user,
    this.first_name,
    this.last_name,
    this.bio,
    this.profile_picture,
    this.preferred_language,
    this.notification_settings,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
