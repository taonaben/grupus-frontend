// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResearchModel _$ResearchModelFromJson(Map<String, dynamic> json) =>
    ResearchModel(
      research_area: json['research_area'] as String,
      funding_source: json['funding_source'] as String?,
      principal_investigator: json['principal_investigator'] as String,
    );

Map<String, dynamic> _$ResearchModelToJson(ResearchModel instance) =>
    <String, dynamic>{
      'research_area': instance.research_area,
      'funding_source': instance.funding_source,
      'principal_investigator': instance.principal_investigator,
    };
