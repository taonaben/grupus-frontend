import 'package:json_annotation/json_annotation.dart';

part 'user_stats.g.dart';

@JsonSerializable()
class UserStats {
  final String? user;
  final int? score;
  final int? reputation_level;
  final int? completed_tasks;

  UserStats({
    this.user,
    this.score,
    this.reputation_level,
    this.completed_tasks,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);
  Map<String, dynamic> toJson() => _$UserStatsToJson(this);
}
