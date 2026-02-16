// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
  end_date: json['end_date'] as String,
  location: json['location'] as String?,
  prize_pool: json['prize_pool'] as List<dynamic>?,
  start_date: json['start_date'] as String,
  max_team_size: (json['max_team_size'] as num?)?.toInt(),
);

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'end_date': instance.end_date,
      'location': instance.location,
      'prize_pool': instance.prize_pool,
      'start_date': instance.start_date,
      'max_team_size': instance.max_team_size,
    };
