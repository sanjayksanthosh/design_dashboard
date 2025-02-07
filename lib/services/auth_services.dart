import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl;

  AuthService({required this.baseUrl});

  /// Calls the login endpoint with the provided [username] and [password].
  /// Returns a parsed JSON map if successful, or throws an exception.
  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/api/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userid': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Assuming the API returns a JSON containing a token and maybe more info.
      return json.decode(response.body);
    } else {
      // You might want to throw different exceptions based on the status code.
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
