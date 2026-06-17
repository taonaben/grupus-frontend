import 'dart:convert';

import 'package:drift/drift.dart';

class JsonMapConverter extends TypeConverter<Map<String, dynamic>, String> {
  const JsonMapConverter();

  @override
  Map<String, dynamic> fromSql(String fromDb) {
    final decoded = jsonDecode(fromDb);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map) {
      return decoded.map((key, value) => MapEntry(key.toString(), value));
    }
    return <String, dynamic>{};
  }

  @override
  String toSql(Map<String, dynamic> value) => jsonEncode(value);
}

class NullableJsonMapConverter
    extends TypeConverter<Map<String, dynamic>?, String?> {
  const NullableJsonMapConverter();

  @override
  Map<String, dynamic>? fromSql(String? fromDb) {
    if (fromDb == null || fromDb.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(fromDb);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map) {
      return decoded.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }

  @override
  String? toSql(Map<String, dynamic>? value) {
    if (value == null) {
      return null;
    }
    return jsonEncode(value);
  }
}

class NullableJsonListConverter extends TypeConverter<List<dynamic>?, String?> {
  const NullableJsonListConverter();

  @override
  List<dynamic>? fromSql(String? fromDb) {
    if (fromDb == null || fromDb.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(fromDb);
    return decoded is List ? decoded : null;
  }

  @override
  String? toSql(List<dynamic>? value) {
    if (value == null) {
      return null;
    }
    return jsonEncode(value);
  }
}
