// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSubscription _$UserSubscriptionFromJson(Map<String, dynamic> json) =>
    UserSubscription(
      user: json['user'] as String?,
      subscription_type: json['subscription_type'] as String?,
      is_premium_member: json['is_premium_member'] as bool?,
      subscription_start: json['subscription_start'] as String?,
      subscription_end: json['subscription_end'] as String?,
    );

Map<String, dynamic> _$UserSubscriptionToJson(UserSubscription instance) =>
    <String, dynamic>{
      'user': instance.user,
      'subscription_type': instance.subscription_type,
      'is_premium_member': instance.is_premium_member,
      'subscription_start': instance.subscription_start,
      'subscription_end': instance.subscription_end,
    };
