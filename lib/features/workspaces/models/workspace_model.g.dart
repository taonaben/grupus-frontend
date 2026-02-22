// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkspaceModel _$WorkspaceModelFromJson(Map<String, dynamic> json) =>
    WorkspaceModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      workspace_type: json['workspace_type'] as String,
      workspace_type_name: json['workspace_type_name'] as String,
      access_code: json['access_code'] as String?,
      is_public: json['is_public'] as bool?,
      requires_approval: json['requires_approval'] as bool?,
      member_count: (json['member_count'] as num?)?.toInt(),
      max_members: (json['max_members'] as num?)?.toInt(),
      channel_count: (json['channel_count'] as num?)?.toInt(),
      group_count: (json['group_count'] as num?)?.toInt(),
      content_guidelines: json['content_guidelines'] as String?,
      rules: json['rules'] as List<dynamic>?,
      metadata: json['metadata'] as Map<String, dynamic>,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      created_by: json['created_by'] as String?,
      typedMetadata: json['typedMetadata'],
    );

Map<String, dynamic> _$WorkspaceModelToJson(WorkspaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'workspace_type': instance.workspace_type,
      'workspace_type_name': instance.workspace_type_name,
      'access_code': instance.access_code,
      'is_public': instance.is_public,
      'requires_approval': instance.requires_approval,
      'member_count': instance.member_count,
      'max_members': instance.max_members,
      'channel_count': instance.channel_count,
      'group_count': instance.group_count,
      'content_guidelines': instance.content_guidelines,
      'rules': instance.rules,
      'metadata': instance.metadata,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'created_by': instance.created_by,
      'typedMetadata': instance.typedMetadata,
    };
