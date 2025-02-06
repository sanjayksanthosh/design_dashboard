// user_provider.dart
import 'package:flutter/material.dart';
import 'package:hidden_dash_new/models/userModel.dart';
import 'package:hidden_dash_new/services/user_services.dart';

class UserProvider with ChangeNotifier {
  final UserService userService;
  List<User> _users = [];
  User? _user;
  String _searchQuery = '';
  User? _currentUser;

  UserProvider(this.userService);

  List<User> get users => _users.where((user) {
        return user.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.userId.toLowerCase().contains(_searchQuery.toLowerCase()) ;
      }).toList();

  User? get user => _user;
  String get searchQuery => _searchQuery;
  User? get currentUser => _currentUser;

  void setCurrentUser(User user) {
    _currentUser = user;
    print(_currentUser!.balance);
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    _users = await userService.fetchUsers();
    notifyListeners();
  }

  Future<void> fetchUser(String userId) async {
    _user = await userService.fetchUser(userId);
    notifyListeners();
  }

  Future<bool> registerUser(Map<String, dynamic> userData) async {
    try {
      print("Registering user...");
      final success = await userService.registerUser(userData);
      if (success) {
        await fetchUsers(); // Refresh user list after registration
      }
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateStatus(String userId, String status, String reason) async {
    try {
      print("Updating status for $userId to $status with reason: $reason");
      final success = await userService.updateStatus(userId, status, reason);
      if (success) {
        await fetchUsers(); // Refresh user list after update
      }
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
