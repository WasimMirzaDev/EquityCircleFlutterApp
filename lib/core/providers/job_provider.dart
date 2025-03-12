import 'package:equitycircle/core/api/job_api.dart';
import 'package:equitycircle/core/models/job_model.dart';
import 'package:flutter/material.dart';

class JobProvider extends ChangeNotifier {
  List<Job> jobLists = []; // Change to List<Job>
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getJobLists(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await JobApi.getJobLists(context);
      jobLists = response; // Directly assign the List<Job>
    } catch (e) {
      throw Exception('Failed to connect to API: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
