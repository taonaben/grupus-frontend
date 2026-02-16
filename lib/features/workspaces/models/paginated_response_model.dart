import 'package:json_annotation/json_annotation.dart';

part 'paginated_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponseModel<T> {
  final List<T> results;
  final int? count;
  final String? next;
  final String? previous;
  final Map<String, dynamic>? metadata;

  PaginatedResponseModel({
    required this.results,
    this.count,
    this.next,
    this.previous,
    this.metadata,
  });

  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$PaginatedResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$PaginatedResponseModelToJson(this, toJsonT);

  bool get hasNextPage => next != null;
  bool get hasPreviousPage => previous != null;
}
