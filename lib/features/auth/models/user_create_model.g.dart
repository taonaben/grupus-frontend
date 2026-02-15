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
      isEmailVerified: json['is_email_verified'] as bool?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      bio: json['bio'] as String?,
      profilePicture: json['profile_picture'] as String?,
      preferredLanguage: json['preferred_language'] as String?,
      notificationSettings: json['notification_settings'] as String?,
    );

Map<String, dynamic> _$UserCreateModelToJson(UserCreateModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'password2': instance.password2,
      'is_email_verified': instance.isEmailVerified,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'bio': instance.bio,
      'profile_picture': instance.profilePicture,
      'preferred_language': instance.preferredLanguage,
      'notification_settings': instance.notificationSettings,
    };
