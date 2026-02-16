import 'package:json_annotation/json_annotation.dart';

part 'research_model.g.dart';

@JsonSerializable()
class ResearchModel {
  final String research_area;
  final String? funding_source;
  final String principal_investigator;

  ResearchModel({
    required this.research_area,
    this.funding_source,
    required this.principal_investigator,
  });

  factory ResearchModel.fromJson(Map<String, dynamic> json) =>
      _$ResearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResearchModelToJson(this);
}
