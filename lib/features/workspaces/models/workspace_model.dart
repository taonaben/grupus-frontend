import 'package:json_annotation/json_annotation.dart';
import 'package:grupus/features/workspaces/utils/workspace_type_mapper.dart';

part 'workspace_model.g.dart';

@JsonSerializable()
class WorkspaceModel {
  final String? id;
  final String name;
  final String? description;
  final String workspace_type;
  final String workspace_type_name;
  final String? access_code;
  final bool? is_public;
  final bool? requires_approval;
  final int? member_count;
  final int? max_members;
  final int? channel_count;
  final int? group_count;
  final String? content_guidelines;
  final List? rules;
  final Map<String, dynamic> metadata;
  final String? created_at;
  final String? updated_at;
  final String? created_by;

  /// Strongly typed metadata based on workspace_type
  /// Auto-cast from the generic metadata field during deserialization
  @JsonKey(ignore: true)
  final Object? typedMetadata;

  WorkspaceModel({
    this.id,
    required this.name,
    this.description,
    required this.workspace_type,
    required this.workspace_type_name,
    this.access_code,
    this.is_public,
    this.requires_approval,
    this.member_count,
    this.max_members,
    this.channel_count,
    this.group_count,
    this.content_guidelines,
    this.rules,
    required this.metadata,
    this.created_at,
    this.updated_at,
    this.created_by,
    this.typedMetadata,
  });

  factory WorkspaceModel.fromJson(Map<String, dynamic> json) {
    final model = _$WorkspaceModelFromJson(json);

    // Cast metadata to the appropriate type model
    final typedMetadata = WorkspaceTypeMapper.castMetadata(
      model.workspace_type,
      model.metadata,
    );

    // Return a new instance with the typed metadata
    return WorkspaceModel(
      id: model.id,
      name: model.name,
      description: model.description,
      workspace_type: model.workspace_type,
      workspace_type_name: model.workspace_type_name,
      access_code: model.access_code,
      is_public: model.is_public,
      requires_approval: model.requires_approval,
      member_count: model.member_count,
      max_members: model.max_members,
      channel_count: model.channel_count,
      group_count: model.group_count,
      content_guidelines: model.content_guidelines,
      rules: model.rules,
      metadata: model.metadata,
      created_at: model.created_at,
      updated_at: model.updated_at,
      created_by: model.created_by,
      typedMetadata: typedMetadata,
    );
  }

  Map<String, dynamic> toJson() => _$WorkspaceModelToJson(this);
}
