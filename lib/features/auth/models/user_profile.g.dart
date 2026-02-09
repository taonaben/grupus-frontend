// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
  user: json['user'] as String?,
  first_name: json['first_name'] as String?,
  last_name: json['last_name'] as String?,
  bio: json['bio'] as String?,
  profile_picture: json['profile_picture'] as String?,
  preferred_language: json['preferred_language'] as String?,
  notification_settings: json['notification_settings'] as String?,
);

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'user': instance.user,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'bio': instance.bio,
      'profile_picture': instance.profile_picture,
      'preferred_language': instance.preferred_language,
      'notification_settings': instance.notification_settings,
    };
