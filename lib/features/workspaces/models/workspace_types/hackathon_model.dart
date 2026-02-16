import 'package:json_annotation/json_annotation.dart';

part 'hackathon_model.g.dart';

@JsonSerializable()
class HackathonModel {
  final String end_date;
  final String? location;
  final List? prize_pool;
  final String start_date;
  final int? max_team_size;

  HackathonModel({
    required this.end_date,
    this.location,
    this.prize_pool,
    required this.start_date,
    this.max_team_size,
  });

  factory HackathonModel.fromJson(Map<String, dynamic> json) =>
      _$HackathonModelFromJson(json);

  Map<String, dynamic> toJson() => _$HackathonModelToJson(this);
}
