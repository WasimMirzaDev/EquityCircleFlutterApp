import 'package:equitycircle/core/api/education_api.dart';
import 'package:flutter/material.dart';

import '../models/create_education_model.dart';
import '../models/education_model.dart';

class EducationProvider extends ChangeNotifier {
  List<EducationModel> educationContent = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getEducation(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      List<dynamic> response = await EducationApi.getEducation(context);
      educationContent =
          response.map((e) => EducationModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to connect to API: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createEducation(
    BuildContext context,
    String title,
    String shortDescription,
    String description,
    String image,
    String videoUrl,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      CreateEducationModel newEducation = await EducationApi.createEducation(
        context,
        title,
        shortDescription,
        description,
        image,
        videoUrl,
      );

      educationContent.insert(
        0,
        EducationModel(
          id: newEducation.id,
          userId: newEducation.userId,
          title: newEducation.title,
          imagePath: newEducation.imagePath,
          shortDescription: newEducation.shortDescription,
          description: newEducation.description,
          videoUrl: newEducation.videoUrl,
          createdAt: newEducation.createdAt,
          updatedAt: newEducation.updatedAt,
        ),
      );
    } catch (e) {
      throw Exception('Failed to create education: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
