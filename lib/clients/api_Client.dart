// lib/services/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

/// A generic API client that handles:
/// - Base URL
/// - Access token (for Authorization header)
/// - Common headers and JSON encoding
/// - Common status code checks / error handling
class ApiClient {
  final String baseUrl;
  String? _accessToken;

  ApiClient({required this.baseUrl});

  /// Call this after obtaining or refreshing the token
  void setAccessToken(String token) {
    _accessToken = token;
  }

  /// GET request
  Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = _createHeaders();
    try {
      final response = await http.get(uri, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error (GET $endpoint): $e');
    }
  }

  /// POST request
  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic>? body, {
    String? customBearerToken,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = _createHeaders(customBearerToken: customBearerToken);

    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: body == null ? null : jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error (POST $endpoint): $e');
    }
  }

  /// PUT request
  Future<dynamic> put(String endpoint, Map<String, dynamic>? body) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = _createHeaders();

    try {
      final response = await http.put(
        uri,
        headers: headers,
        body: body == null ? null : jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error (PUT $endpoint): $e');
    }
  }

  /// Create headers, including Authorization if we have a token.
  /// Optionally use a different token if `customBearerToken` is provided
  Map<String, String> _createHeaders({String? customBearerToken}) {
    final headers = {'Content-Type': 'application/json'};
    final token = customBearerToken ?? _accessToken;
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  /// Handle response and throw exceptions for error codes
  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      case 400:
        throw Exception('Bad request: ${response.body}');
      case 401:
        throw Exception('Unauthorized: ${response.body}');
      case 404:
        throw Exception('Not found: ${response.body}');
      case 500:
        throw Exception('Server error: ${response.body}');
      default:
        throw Exception(
          'Unexpected error (${response.statusCode}): ${response.body}',
        );
    }
  }
}
