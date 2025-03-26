import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equitycircle/core/api/api_service.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/create_post_model.dart';

class FeedsApi {
  static Future<CreatePostResponse?> editPost(
    BuildContext context,
    String id,
    String title,
    String description,
    String categoryId,
    String visibility,
    List<File> images,
    List<File> videos,
  ) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

      if (token == null) throw Exception("User not authenticated");

      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('title', title),
        MapEntry('description', description),
        MapEntry(
          'category_id',
          int.parse(categoryId).toString(),
        ), // Ensure it's an integer
        MapEntry('visibility', visibility.toLowerCase()),
        MapEntry('_method', "PUT"),
      ]);

      for (var image in images) {
        formData.files.add(
          MapEntry(
            'images[]',
            await MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            ),
          ),
        );
      }

      for (var video in videos) {
        formData.files.add(
          MapEntry(
            'videos[]',
            await MultipartFile.fromFile(
              video.path,
              filename: video.path.split('/').last,
            ),
          ),
        );
      }

      debugPrint("🔹 Sending FormData:");
      for (var field in formData.fields) {
        debugPrint("${field.key}: ${field.value}");
      }
      for (var file in formData.files) {
        debugPrint("${file.key}: ${file.value.filename}");
      }

      Response response = await ApiService.postRequest(
        '/posts/$id',
        formData,
        token,
      );

      // Success response
      debugPrint("✅ Create Post Response: ${response.data}");
      return CreatePostResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("❌ Error Response: ${e.response?.data}");
      throw Exception("Post Creation failed: ${e.response?.data}");
    } catch (error) {
      throw Exception("Unexpected Error: $error");
    }
  }

  static Future<CreatePostResponse?> createPost(
    BuildContext context,
    String title,
    String description,
    String categoryId,
    String visibility,
    List<File> images,
    List<File> videos,
  ) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

      if (token == null) throw Exception("User not authenticated");

      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('title', title),
        MapEntry('description', description),
        MapEntry(
          'category_id',
          int.parse(categoryId).toString(),
        ), // Ensure it's an integer
        MapEntry('visibility', visibility.toLowerCase()),
      ]);

      for (var image in images) {
        formData.files.add(
          MapEntry(
            'images[]',
            await MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            ),
          ),
        );
      }

      for (var video in videos) {
        formData.files.add(
          MapEntry(
            'videos[]',
            await MultipartFile.fromFile(
              video.path,
              filename: video.path.split('/').last,
            ),
          ),
        );
      }

      debugPrint("🔹 Sending FormData:");
      for (var field in formData.fields) {
        debugPrint("${field.key}: ${field.value}");
      }
      for (var file in formData.files) {
        debugPrint("${file.key}: ${file.value.filename}");
      }

      Response response = await ApiService.postRequest(
        '/posts',
        formData,
        token,
      );

      // Success response
      debugPrint("✅ Create Post Response: ${response.data}");
      return CreatePostResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("❌ Error Response: ${e.response?.data}");
      throw Exception("Post Creation failed: ${e.response?.data}");
    } catch (error) {
      throw Exception("Unexpected Error: $error");
    }
  }

  static Future<Response> getFeeds(
    BuildContext context, {
    int page = 1,
    int category_id = 0,
  }) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

      if (token == null) throw Exception("User not authenticated");

      Response response = await ApiService.getRequest(
        '/posts?page=$page&category=$category_id',
        token,
      );
      return response;
    } catch (e) {
      throw Exception("Failed to fetch data: $e");
    }
  }

  static Future<Response> likeFeed(BuildContext context, int feedId) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

      if (token == null) throw Exception("User not authenticated");

      Response response = await ApiService.postRequest(
        '/posts/$feedId/like',
        {},
        token,
      );
      return response;
    } catch (e) {
      throw Exception("Failed to fetch data: $e");
    }
  }

  static Future<Response> postComment(
    BuildContext context,
    int feedId,
    String comment,
  ) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

      if (token == null) throw Exception("User not authenticated");

      Response response = await ApiService.postRequest(
        '/posts/$feedId/comment',
        {'content': comment},
        token,
      );
      return response;
    } catch (e) {
      throw Exception("Failed to post comment: $e");
    }
  }
}
