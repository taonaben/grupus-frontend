// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkspaceCreateModel _$WorkspaceCreateModelFromJson(
  Map<String, dynamic> json,
) => WorkspaceCreateModel(
  name: json['name'] as String,
  description: json['description'] as String?,
  workspace_type: json['workspace_type'] as String,
  is_public: json['is_public'] as bool?,
  requires_approval: json['requires_approval'] as bool?,
  max_members: (json['max_members'] as num?)?.toInt(),
  content_guidelines: json['content_guidelines'] as String?,
);

Map<String, dynamic> _$WorkspaceCreateModelToJson(
  WorkspaceCreateModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'workspace_type': instance.workspace_type,
  'is_public': instance.is_public,
  'requires_approval': instance.requires_approval,
  'max_members': instance.max_members,
  'content_guidelines': instance.content_guidelines,
};
