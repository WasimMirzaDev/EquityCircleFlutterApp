import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'api_service.dart'; // your centralized API service

class AuthApi {
  static Future<Map<String, dynamic>> admin(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

      if (token == null) throw Exception("User not authenticated");

      final response = await ApiService.getRequest('/users/is_admin', token);
      return response.data;
    } catch (error) {
      throw Exception("Admin API failed: $error");
    }
  }

  // Function to handle user login
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await ApiService.postRequest('/login', {
        'email': email,
        'password': password,
      });
      return response
          .data; // assuming it returns a JSON map containing user data and token
    } catch (error) {
      // Handle errors appropriately
      throw Exception("Login failed: $error");
    }
  }

  static Future<Map<String, dynamic>> saveToken(
    String firebasetoken,
    String token,
  ) async {
    try {
      final response = await ApiService.postRequest('/save-token', {
        'fcm_token': firebasetoken,
      }, token);
      return response
          .data; // assuming it returns a JSON map containing user data and token
    } catch (error) {
      // Handle errors appropriately
      throw Exception("Login failed: $error");
    }
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final response = await ApiService.postRequest('/register', {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
      return response.data;
    } catch (error) {
      // Handle errors appropriately
      throw Exception("Register failed: $error");
    }
  }

  static Future<Map<String, dynamic>> getUserData(String token) async {
    try {
      final response = await ApiService.getRequest('/user', token);
      return response.data;
    } catch (error) {
      // Handle errors appropriately
      throw Exception("Login failed: $error");
    }
  }

  static Future<Map<String, dynamic>> sendUserDataToBackend(
    String? name,
    String? email,
    String? photo,
    String? idToken,
  ) async {
    final response = await ApiService.postRequest('/auth/google-login', {
      'name': name,
      'email': email,
      'photo': photo,
      'id_token': idToken,
    });

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Login failed: $response");
    }
  }
}
