import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equitycircle/core/api/api_service.dart';
import 'package:equitycircle/core/models/job_list_model.dart'
    show DataByJobList, JobListModel;
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/create_job_model.dart';

class JobApi {
  static Future<List<DataByJobList>> getJobLists(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;
      if (token == null) throw Exception("User not authenticated");

      final response = await ApiService.getRequest('/jobs', token);
      print("Raw API Response: ${response.data}");

      if (response.statusCode == 200) {
        final jobListModel = JobListModel.fromJson(response.data);
        return jobListModel.jobs?.data ?? [];
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to connect to API: $e');
    }
  }

  static Future<CreateJobModel> createJob(
    BuildContext context,
    String title,
    String shortDescription,
    String description,
    String image,
  ) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

      if (token == null) throw Exception("User not authenticated");

      // Debug info
      print('Creating job with:');
      print('Title: $title');
      print('Short Description: $shortDescription');
      print('Description: $description');
      print('Image Path: $image');
      print('File exists: ${File(image).existsSync()}');

      // Validate image file
      if (image.isEmpty || !File(image).existsSync()) {
        throw Exception("Image file is missing or invalid");
      }

      final file = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );

      FormData formData = FormData.fromMap({
        'title': title,
        'short_description': shortDescription,
        'description': description,
        'main_image': file,
      });

      final response = await ApiService.postRequest('/jobs', formData, token);

      print('Create Job Response: ${response.statusCode}');
      print('Create Job Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreateJobModel.fromJson(response.data);
      } else {
        throw Exception('Failed to create job: ${response.statusCode}');
      }
    } catch (error) {
      print('Error in createJob: $error');
      throw Exception("Create job failed: $error");
    }
  }
}
