// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationModel _$RegistrationModelFromJson(Map<String, dynamic> json) =>
    RegistrationModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      bio: json['bio'] as String?,
      profilePicture: json['profile_picture'] as String?,
      preferredLanguage: json['preferred_language'] as String?,
      notificationSettings: json['notification_settings'] as String?,
      otp: (json['otp'] as num?)?.toInt(),
      step: (json['step'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RegistrationModelToJson(RegistrationModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'bio': instance.bio,
      'profile_picture': instance.profilePicture,
      'preferred_language': instance.preferredLanguage,
      'notification_settings': instance.notificationSettings,
      'otp': instance.otp,
      'step': instance.step,
    };
