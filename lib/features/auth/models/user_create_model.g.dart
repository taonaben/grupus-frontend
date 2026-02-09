// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateModel _$UserCreateModelFromJson(Map<String, dynamic> json) =>
    UserCreateModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      password2: json['password2'] as String,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      bio: json['bio'] as String?,
      profile_picture: json['profile_picture'] as String?,
      preferred_language: json['preferred_language'] as String?,
      notification_settings: json['notification_settings'] as String?,
    );

Map<String, dynamic> _$UserCreateModelToJson(UserCreateModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'password2': instance.password2,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'bio': instance.bio,
      'profile_picture': instance.profile_picture,
      'preferred_language': instance.preferred_language,
      'notification_settings': instance.notification_settings,
    };
