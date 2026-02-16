/// Flexible wrapper for list API responses
/// Preserves all response data while providing convenient access to items and metadata
class ApiListResponse<T> {
  final List<T> items;
  final Map<String, dynamic> rawData;

  ApiListResponse({required this.items, required this.rawData});

  /// Get pagination metadata if available
  T? getMetadata<T>(String key) {
    return rawData[key] as T?;
  }

  /// Convenience accessors for common pagination fields
  int? get pageCount => getMetadata<int>('count');
  String? get nextUrl => getMetadata<String>('next');
  String? get previousUrl => getMetadata<String>('previous');
  int? get pageNumber => getMetadata<int>('page');
  int? get pageSize => getMetadata<int>('page_size');

  /// Access any custom metadata fields
  Map<String, dynamic> getCustomMetadata() {
    final excluded = {
      'results',
      'count',
      'next',
      'previous',
      'page',
      'page_size',
    };
    return Map.fromEntries(
      rawData.entries.where((e) => !excluded.contains(e.key)),
    );
  }
}
