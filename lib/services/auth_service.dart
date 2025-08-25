import 'dart:convert';
import 'package:counter_app/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _userKey = 'user_list_json';
  static const _currentUserKey = 'current_user_email';

  Future<List<UserModel>> _loadUsers(SharedPreferences prefs) async {
    final jsonString = prefs.getString(_userKey);
    if (jsonString == null) return [];
    final List<dynamic> list = json.decode(jsonString) as List<dynamic>;
    return list.map((user) => UserModel.formJson(user)).toList();
  }

  Future<void> _saveUser(SharedPreferences prefs, List<UserModel> users) async {
    final encoded = json.encode(users.map((user) => user.toJson()).toList());
    await prefs.setString(_userKey, encoded);
  }

  Future<bool> registerUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _loadUsers(prefs);

    final exists = users.any(
      (data) => data.email!.toLowerCase() == user.email!.toLowerCase(),
    );
    if (exists) return false;

    users.add(user);
    await _saveUser(prefs, users);
    return true;
  }

  Future<UserModel?> authenticate(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _loadUsers(prefs);

    try {
      return users.firstWhere(
        (user) =>
            user.email!.toLowerCase() == email.toLowerCase() &&
            user.password == password,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Authenticate Error : ${e.toString()}");
      }
      return null;
    }
  }

  Future<void> setCurrentUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, email);
  }

  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_currentUserKey);

    if (email == null) return null;

    final users = await _loadUsers(prefs);
    try {
      return users.firstWhere(
        (user) => user.email!.toLowerCase() == email.toLowerCase(),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Get current user Error : ${e.toString()}");
      }
      return null; // ✅ fixed
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }
}
