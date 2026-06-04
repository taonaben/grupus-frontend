// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelModel _$ChannelModelFromJson(Map<String, dynamic> json) => ChannelModel(
  id: json['id'] as String,
  workspace: json['workspace'] as String?,
  group: json['group'] as String?,
  name: json['name'] as String,
  is_private: json['is_private'] as bool,
  created_by: json['created_by'] as String?,
  created_at: json['created_at'] as String?,
);

Map<String, dynamic> _$ChannelModelToJson(ChannelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workspace': instance.workspace,
      'group': instance.group,
      'name': instance.name,
      'is_private': instance.is_private,
      'created_by': instance.created_by,
      'created_at': instance.created_at,
    };
