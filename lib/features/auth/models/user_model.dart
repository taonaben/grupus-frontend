import 'package:grupus/features/auth/models/user_profile.dart';
import 'package:grupus/features/auth/models/user_stats.dart';
import 'package:grupus/features/auth/models/user_subscription.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String username;
  final String email;
  final UserProfile profile;
  final UserStats stats;
  final UserSubscription subscription;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.profile,
    required this.stats,
    required this.subscription,
  });

  User copyWith({
    int? id,
    String? username,
    String? email,
    UserProfile? profile,
    UserStats? stats,
    UserSubscription? subscription,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profile: profile ?? this.profile,
      stats: stats ?? this.stats,
      subscription: subscription ?? this.subscription,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
