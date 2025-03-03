import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/auth_api.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  Map<String, dynamic>? _userData; // Store user data

  String? get token => _token;
  Map<String, dynamic>? get userData => _userData;
  bool get isAuthenticated => _token != null; // Check if user is logged in

  AuthProvider() {
    _loadUserData(); // Load token & fetch user on app start
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token');

    if (_token != null) {
      await fetchUser(); // Fetch user data if token exists
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final data = await AuthApi.login(email, password);
      _token = data['access_token'];

      // Store token locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', _token!);

      await fetchUser(); // Fetch user data after login
      notifyListeners();
      return true;
    } catch (error) {
      print("Error during login: $error");
      return false;
    }
  }

  Future<bool> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final data = await AuthApi.register(
        name,
        email,
        password,
        passwordConfirmation,
      );
      _token = data['access_token']; // assuming the API returns a token

      // Optionally, store token locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', _token!);

      notifyListeners();
      return true;
    } catch (error) {
      // Handle login errors
      print("Error during login: $error");
      return false;
    }
  }

  Future<void> fetchUser() async {
    try {
      if (_token == null) return;

      final data = await AuthApi.getUserData(
        _token!,
      ); // Call API to get user data
      _userData = data;

      notifyListeners();
    } catch (e) {
      print("Error fetching user: $e");
      logout(); // Logout if fetching fails (invalid token)
    }
  }

  Future<void> logout() async {
    _token = null;
    _userData = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token'); // Remove token from storage

    notifyListeners();
  }
}
