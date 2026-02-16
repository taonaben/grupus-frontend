import 'package:json_annotation/json_annotation.dart';

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
  });

  factory WorkspaceModel.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceModelToJson(this);
}
