// lib/services/auth_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class AuthService {
 

  AuthService();


  Future<Map<String, dynamic>> login(String userid, String password) async {
    final url = Uri.parse('$kApiBaseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'staffId': userid,
        'password': password,
      }),
    );
print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  /// Calls the refresh-token endpoint using the [refreshToken].
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final url = Uri.parse('$kApiBaseUrl/auth/refresh-token');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken', // Using the refresh token
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to refresh token: ${response.statusCode}');
    }
  }

  /// Calls the logout endpoint.
  /// No 'Authorization' header is sent if the server expects to read
  /// the refresh token from an HTTP-only cookie.
  Future<void> logout() async {
    final url = Uri.parse('$kApiBaseUrl/auth/logout');
         final prefs = await SharedPreferences.getInstance();
        String? token=await prefs.getString('accessToken');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':'Bearer $token'
        // Omit 'Authorization' if the server expects a cookie-based token.
      },
    );

    // Optionally log the response for debugging:
    print('Logout response status: ${response.statusCode}');
    print('Logout response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to logout: ${response.body}');
    }
  }
}
