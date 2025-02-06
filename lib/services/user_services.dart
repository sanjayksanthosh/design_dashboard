// user_services.dart
import 'dart:convert';
import 'package:hidden_dash_new/models/userModel.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl;

  UserService(this.baseUrl);

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/user/allUsers'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> fetchUser(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<bool> updateStatus(String userId, String status, String reason) async {
    print(status);
    final response = await http.put(
      Uri.parse('$baseUrl/user/updateStatus'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "userId": userId,
        "status": status.toLowerCase(),
        "reason": reason,
      }),
    );
    print("response: ${response.body}");
    // Assuming a 200 status code means success
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
