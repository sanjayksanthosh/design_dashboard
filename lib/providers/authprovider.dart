import 'package:flutter/material.dart';
import 'package:hidden_dash_new/services/auth_services.dart';

class AuthProvider with ChangeNotifier {
  final AuthService authService;

  AuthProvider({required this.authService});

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  String? _token;
  String? get token => _token;

  /// Attempts to log in using the provided [formData].
  /// Returns `true` if successful; otherwise, `false`.
  Future<bool> login(Map<String, dynamic> formData) async {
    try {
      final response = await authService.login(
        formData['userid'],
        formData['password'],
      );
      // Process the response; assume the API returns a token on successful login.
      if (response.containsKey('token')) {
        _token = response['token'];
        _isAuthenticated = true;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Optionally log the error or process it further.
      print('Login error: $e');
      return false;
    }
  }
}
