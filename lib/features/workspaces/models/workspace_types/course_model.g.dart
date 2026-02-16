// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
  credits: (json['credits'] as num?)?.toDouble(),
  semester: json['semester'] as String,
  coordinator: json['coordinator'] as String,
  course_code: json['course_code'] as String,
  academic_year: json['academic_year'] as String,
);

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'credits': instance.credits,
      'semester': instance.semester,
      'coordinator': instance.coordinator,
      'course_code': instance.course_code,
      'academic_year': instance.academic_year,
    };
