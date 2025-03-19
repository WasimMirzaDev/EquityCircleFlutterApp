import 'package:dio/dio.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/core/api/api_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FeedsApi {
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
