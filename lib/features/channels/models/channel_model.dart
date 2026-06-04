import 'package:json_annotation/json_annotation.dart';

part 'channel_model.g.dart';

@JsonSerializable()
class ChannelModel {
  final String id;
  final String? workspace;
  final String? group;
  final String name;
  final bool is_private;
  final String? created_by;
  final String? created_at;

  ChannelModel({
    required this.id,
    this.workspace,
    this.group,
    required this.name,
    required this.is_private,
    this.created_by,
    this.created_at,
  });

  /// Chat WebSocket room scope id comes from workspace or group in the DTO.
  String? get roomScopeId => workspace ?? group;

  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelModelToJson(this);
}
