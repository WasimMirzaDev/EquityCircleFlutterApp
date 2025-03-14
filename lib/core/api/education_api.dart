import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/core/api/api_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class EducationApi {
  static Future getEducation(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

      if (token == null) throw Exception("User not authenticated");

      final response = await ApiService.getRequest(
        '/education-contents',
        token,
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return data;
      } else {
        throw Exception('Failed to load education');
      }
    } catch (e) {
      throw Exception('Failed to connect to API: $e');
    }
  }
}
