// lib/services/user_services.dart
import 'dart:convert';
import 'package:hidden_dash_new/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class UserService {
  final String baseUrl;

  UserService({this.baseUrl = kApiBaseUrl});

  Future<List<User>> fetchUsers() async {
            final prefs = await SharedPreferences.getInstance();
        String? token=await prefs.getString('accessToken');
    final url = Uri.parse('$baseUrl/user/allUsers');
    print(token);
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> fetchUser(String userId) async {
      final prefs = await SharedPreferences.getInstance();
        String? token=await prefs.getString('accessToken');
    final url = Uri.parse('$baseUrl/users/$userId');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<bool> updateStatus(String userId, String status, String reason) async {
      final prefs = await SharedPreferences.getInstance();
        String? token=await prefs.getString('accessToken');
    final url = Uri.parse('$baseUrl/user/updateStatus');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final response = await http.put(
      url,
      headers: headers,
      body: json.encode({
        "userId": userId,
        "status": status.toLowerCase(),
        "reason": reason,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
        String? token=await prefs.getString('accessToken');
    final url = Uri.parse('$baseUrl/user/register');
    final headers = {'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
    };
    // Registration typically does not require an auth token.
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(userData),
      
    );
    var data = jsonDecode(response.body);
    print(response.body);

    if (data['message'] == "User created successfully") {
      return true;
    } else {
      return false;
    }
  }
}
