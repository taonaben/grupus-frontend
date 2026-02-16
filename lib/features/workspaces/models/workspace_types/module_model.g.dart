// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleModel _$ModuleModelFromJson(Map<String, dynamic> json) => ModuleModel(
  weight: (json['weight'] as num?)?.toDouble(),
  module_code: json['module_code'] as String,
  lead_lecturer: json['lead_lecturer'] as String?,
  parent_course: json['parent_course'] as String?,
);

Map<String, dynamic> _$ModuleModelToJson(ModuleModel instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'module_code': instance.module_code,
      'lead_lecturer': instance.lead_lecturer,
      'parent_course': instance.parent_course,
    };
