import 'package:dio/dio.dart';
import 'package:equitycircle/core/api/api_service.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/create_education_model.dart';

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

  static Future<CreateEducationModel> createEducation(
    BuildContext context,
    String title,
    String shortDescription,
    String description,
    String image,
    String videoUrl,
  ) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

      if (token == null) throw Exception("User not authenticated");

      FormData formData = FormData.fromMap({
        'title': title,
        'short_description': shortDescription,
        'description': description,
        'video_url': videoUrl,
        'image': await MultipartFile.fromFile(image),
      });

      final response = await ApiService.postRequest(
        '/education-contents',
        formData,
        token,
      );
      print('createEducation Response: ${response.statusCode}');
      print('createEducation Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreateEducationModel.fromJson(response.data);
      } else {
        throw Exception('Failed to create education');
      }
    } catch (error) {
      print('Error in createEducation: $error');
      throw Exception("Create Education failed: $error");
    }
  }
}
