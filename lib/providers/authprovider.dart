import 'package:flutter/material.dart';
import 'package:hidden_dash_new/services/auth_services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final AuthService authService;

  AuthProvider({required this.authService});

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  String? _accessToken;
  String? _refreshToken;

  String? get token => _accessToken; // For convenience

  Future<bool> login(Map<String, dynamic> formData) async {
    try {
      final response = await authService.login(
        formData['userid'],
        formData['password'],
      );

      // Expecting something like { "accessToken": "...", "refreshToken": "..." }
      if (response.containsKey('accessToken') ) {
        _accessToken = response['accessToken'];
      
        // Save both in local storage (ideally secure storage for the refresh token).
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', _accessToken!);
   

        _isAuthenticated = true;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<bool> refreshToken() async {
    if (_refreshToken == null) return false; // we need the refresh token here
    try {
      final response = await authService.refreshToken(_refreshToken!);
      if (response.containsKey('accessToken')) {
        _accessToken = response['accessToken'];

        // Some APIs also return a new refreshToken. If so:
        if (response.containsKey('refreshToken')) {
          _refreshToken = response['refreshToken'];
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', _accessToken!);
        if (_refreshToken != null) {
          await prefs.setString('refreshToken', _refreshToken!);
        }

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Refresh token error: $e');
      return false;
    }
  }

  Future<bool> logout() async {
    if (_accessToken == null && _refreshToken == null) return false;
    try {
      await authService.logout();
      _accessToken = null;
      _refreshToken = null;
      _isAuthenticated = false;

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');

      notifyListeners();
      return true;
    } catch (e) {
      print('Logout error: $e');
      return false;
    }
  }

  // Attempt auto-login by reading from SharedPreferences
  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('accessToken') ||
        !prefs.containsKey('refreshToken')) {
      return;
    }

    final storedAccessToken = prefs.getString('accessToken')!;
    final storedRefreshToken = prefs.getString('refreshToken')!;

    // If the access token is expired, call refresh
    if (JwtDecoder.isExpired(storedAccessToken)) {
      _refreshToken = storedRefreshToken;
      bool refreshed = await refreshToken();
      if (!refreshed) {
        await logout();
        return;
      }
    } else {
      _accessToken = storedAccessToken;
      _refreshToken = storedRefreshToken;
    }

    _isAuthenticated = true;
    notifyListeners();
  }
}
