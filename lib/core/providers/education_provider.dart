import 'package:equitycircle/core/api/education_api.dart';
import 'package:flutter/material.dart';

class EducationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> educationContent = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> getEducation(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      List<dynamic> response = await EducationApi.getEducation(context);
      educationContent = List<Map<String, dynamic>>.from(
        response,
      ); // ✅ Correctly convert list
    } catch (e) {
      throw Exception('Failed to connect to API: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
