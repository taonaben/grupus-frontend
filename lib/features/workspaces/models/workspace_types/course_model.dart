import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  final double? credits;
  final String semester;
  final String coordinator;
  final String course_code;
  final String academic_year;

  CourseModel({
    this.credits,
    required this.semester,
    required this.coordinator,
    required this.course_code,
    required this.academic_year,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
