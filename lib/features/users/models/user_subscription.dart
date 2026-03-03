import 'package:json_annotation/json_annotation.dart';

part 'user_subscription.g.dart';

@JsonSerializable()
class UserSubscription {
  final String? user;
  final String? subscription_type;
  final bool? is_premium_member;
  final String? subscription_start;
  final String? subscription_end;

  UserSubscription({
    this.user,
    this.subscription_type,
    this.is_premium_member,
    this.subscription_start,
    this.subscription_end,
  });

  factory UserSubscription.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$UserSubscriptionToJson(this);
}
