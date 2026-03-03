// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStats _$UserStatsFromJson(Map<String, dynamic> json) => UserStats(
  user: json['user'] as String?,
  score: (json['score'] as num?)?.toInt(),
  reputation_level: (json['reputation_level'] as num?)?.toInt(),
  completed_tasks: (json['completed_tasks'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserStatsToJson(UserStats instance) => <String, dynamic>{
  'user': instance.user,
  'score': instance.score,
  'reputation_level': instance.reputation_level,
  'completed_tasks': instance.completed_tasks,
};
