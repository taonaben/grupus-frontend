import 'package:json_annotation/json_annotation.dart';
part 'workspace_create_model.g.dart';

@JsonSerializable()
class WorkspaceCreateModel {
  final String name;
  final String? description;
   final Map<String, dynamic> metadata;
  final String workspace_type;
  final bool? is_public;
  final bool? requires_approval;
  final int? max_members;
  final String? content_guidelines;

  WorkspaceCreateModel({
    required this.name,
    this.description,
    required this.metadata,
    required this.workspace_type,
    this.is_public,
    this.requires_approval,
    this.max_members,
    this.content_guidelines,
  });

  factory WorkspaceCreateModel.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceCreateModelToJson(this);
}
