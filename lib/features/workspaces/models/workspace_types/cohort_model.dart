import 'package:json_annotation/json_annotation.dart';

part 'cohort_model.g.dart';

@JsonSerializable()
class CohortModel {
  final String mentor;
  final String? end_date;
  final String? focus_area;
  final String start_date;

  CohortModel({
    required this.mentor,
    this.end_date,
    this.focus_area,
    required this.start_date,
  });

  factory CohortModel.fromJson(Map<String, dynamic> json) =>
      _$CohortModelFromJson(json);

  Map<String, dynamic> toJson() => _$CohortModelToJson(this);
}
