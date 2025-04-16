import 'dart:convert';

/// Decodes a JSON array string into a `List<T>`.
/// You must provide [constructor] which takes a
/// Map<String, dynamic> and returns a T.
List<T> parseJsonList<T>(
    String jsonString,
    T Function(Map<String, dynamic>) constructor,
    ) {
  final decoded = jsonDecode(jsonString) as List<dynamic>;
  return decoded.map((item) => constructor(item as Map<String, dynamic>)).toList();
}

/// Decodes a JSON object string into a single `T`.
T parseJsonObject<T>(
    String jsonString,
    T Function(Map<String, dynamic>) constructor,
    ) {
  final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
  return constructor(decoded);
}
