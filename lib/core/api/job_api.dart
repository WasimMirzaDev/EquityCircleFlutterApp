import 'package:equitycircle/core/models/job_model.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/core/api/api_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class JobApi {
  static Future<List<Job>> getJobLists(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

      if (token == null) throw Exception("User not authenticated");

      final response = await ApiService.getRequest('/jobs', token);
      if (response.statusCode == 200) {
        final data = response.data['jobs']['data'] as List;
        return data.map((jobJson) => Job.fromJson(jobJson)).toList();
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      throw Exception('Failed to connect to API: $e');
    }
  }
}
