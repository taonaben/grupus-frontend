// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num?)?.toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
  isEmailVerified: json['is_email_verified'] as bool,
  profile: UserProfile.fromJson(json['profile'] as Map<String, dynamic>),
  stats: UserStats.fromJson(json['stats'] as Map<String, dynamic>),
  subscription: UserSubscription.fromJson(
    json['subscription'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'is_email_verified': instance.isEmailVerified,
  'profile': instance.profile,
  'stats': instance.stats,
  'subscription': instance.subscription,
};
