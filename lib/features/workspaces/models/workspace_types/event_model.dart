import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  final String end_date;
  final String? location;
  final List? prize_pool;
  final String start_date;
  final int? max_team_size;

  EventModel({
    required this.end_date,
    this.location,
    this.prize_pool,
    required this.start_date,
    this.max_team_size,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
