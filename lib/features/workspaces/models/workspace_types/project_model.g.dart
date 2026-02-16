// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) => ProjectModel(
  client: json['client'] as String?,
  status: json['status'] as String?,
  deadline: json['deadline'] as String?,
);

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'client': instance.client,
      'status': instance.status,
      'deadline': instance.deadline,
    };
