import 'package:equitycircle/core/api/job_api.dart';
import 'package:flutter/material.dart';

import '../models/create_job_model.dart';
import '../models/job_list_model.dart';

class JobProvider extends ChangeNotifier {
  List<DataByJobList> jobLists = []; // Changed from List<Job> to List<Data>
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<CreateJobModel> jobContent = [];
  Future<void> getJobLists(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await JobApi.getJobLists(context);
      jobLists = response; // This is List<Data>
    } catch (e) {
      throw Exception('Failed to connect to API: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createJob(
    BuildContext context,
    String title,
    String shortDescription,
    String description,
    String image,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await JobApi.createJob(
        context,
        title,
        shortDescription,
        description,
        image,
      );

      // Check if job exists before inserting
      if (response.job != null) {
        jobContent.insert(0, response);

        debugPrint("response: ${response.job}");
      } else {
        throw Exception("Job creation succeeded but no job returned.");
      }
    } catch (e) {
      debugPrint('Error in createJob: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
