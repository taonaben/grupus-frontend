import 'package:grupus/features/users/models/user_profile.dart';
import 'package:grupus/features/users/models/user_stats.dart';
import 'package:grupus/features/users/models/user_subscription.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String? id;
  final String username;
  final String email;
  @JsonKey(name: "is_email_verified")
  final bool isEmailVerified;
  final UserProfile? profile;
  final UserStats? stats;
  final UserSubscription? subscription;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.isEmailVerified,
    this.profile,
    this.stats,
    this.subscription,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    UserProfile? profile,
    bool? isEmailVerified,
    UserStats? stats,
    UserSubscription? subscription,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      profile: profile ?? this.profile,
      stats: stats ?? this.stats,
      subscription: subscription ?? this.subscription,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
