// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cohort_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CohortModel _$CohortModelFromJson(Map<String, dynamic> json) => CohortModel(
  mentor: json['mentor'] as String,
  end_date: json['end_date'] as String?,
  focus_area: json['focus_area'] as String?,
  start_date: json['start_date'] as String,
);

Map<String, dynamic> _$CohortModelToJson(CohortModel instance) =>
    <String, dynamic>{
      'mentor': instance.mentor,
      'end_date': instance.end_date,
      'focus_area': instance.focus_area,
      'start_date': instance.start_date,
    };
