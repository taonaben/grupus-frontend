import 'package:json_annotation/json_annotation.dart';

part 'module_model.g.dart';

@JsonSerializable()
class ModuleModel {
  final double? weight;
  final String module_code;
  final String? lead_lecturer;
  final String? parent_course;

  ModuleModel({
    this.weight,
    required this.module_code,
    this.lead_lecturer,
    this.parent_course,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleModelToJson(this);
}
