import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equitycircle/core/models/feeds_model.dart';
import 'package:flutter/material.dart';

import '../api/feeds_api.dart';
import '../models/create_post_model.dart';

class FeedsProvider with ChangeNotifier {
  final Map<int, List<DataByFeed>> _feedsPerCategory = {};
  final Map<int, bool> _hasMorePerCategory = {};
  final Map<int, int> _currentPagePerCategory = {};
  final Map<int, bool> _isLoadingCommentPerFeed = {};
  bool _isLoading = false;
  // bool _isLoadingComment = false;

  bool get isLoading => _isLoading;
  // bool get isLoadingComment => _isLoadingComment;
  bool isLoadingComment(int feedId) =>
      _isLoadingCommentPerFeed[feedId] ?? false;

  List<DataByFeed> getFeedsByCategory(int categoryId) =>
      _feedsPerCategory[categoryId] ?? [];

  bool hasMore(int categoryId) => _hasMorePerCategory[categoryId] ?? true;
  Future<CreatePostResponse?> editPost(
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
      final response = await FeedsApi.editPost(
        context,
        id,
        title,
        description,
        categoryId,

        visibility,
        images,
        videos,
      );

      debugPrint("Response Edit Post: ${response?.post!}");
      notifyListeners();
      return response;
    } catch (error) {
      print("Error during post: $error");
      return null;
    }
  }

  Future<CreatePostResponse?> createPost(
    BuildContext context,
    String title,
    String description,
    String categoryId,
    String visibility,
    List<File> images,
    List<File> videos,
  ) async {
    try {
      final response = await FeedsApi.createPost(
        context,
        title,
        description,
        categoryId,

        visibility,
        images,
        videos,
      );

      debugPrint("Response Create Post: ${response?.post!}");
      notifyListeners();
      return response;
    } catch (error) {
      print("Error during post creation: $error");
      return null;
    }
  }

  Future<void> fetchFeeds(
    BuildContext context, {
    required int categoryId,
    bool loadMore = false,
    bool refresh = false,
  }) async {
    if (_isLoading || (!hasMore(categoryId) && loadMore)) return;

    if (refresh || !_feedsPerCategory.containsKey(categoryId)) {
      _currentPagePerCategory[categoryId] = 1;
      _hasMorePerCategory[categoryId] = true;
      _feedsPerCategory[categoryId] = [];
      notifyListeners();
    }

    _setLoading(true);

    try {
      Response response = await FeedsApi.getFeeds(
        context,
        page: _currentPagePerCategory[categoryId]!,
        category_id: categoryId,
      );

      FeedsModel feedsModel = FeedsModel.fromJson(response.data);
      _hasMorePerCategory[categoryId] = feedsModel.hasMore ?? false;
      List<DataByFeed> newFeeds = feedsModel.data ?? [];

      if (loadMore) {
        _feedsPerCategory[categoryId]?.addAll(newFeeds);
      } else {
        _feedsPerCategory[categoryId] = newFeeds;
      }

      _currentPagePerCategory[categoryId] = (feedsModel.currentPage ?? 0) + 1;
    } catch (e) {
      print("Error fetching feeds: $e");
    }

    _setLoading(false);
  }

  Future<void> likeFeed(
    int feedId,
    BuildContext context,
    int categoryId,
  ) async {
    try {
      Response response = await FeedsApi.likeFeed(context, feedId);
      if (response.data['success']) {
        _updateFeed(
          categoryId,
          feedId,
          (feed) => feed.copyWith(
            likes:
                (response.data['likes'] as List?)
                    ?.map((e) => LikesByFeeds.fromJson(e))
                    .toList(),
            likesCount: response.data['likes_count'],
          ),
        );
      }
    } catch (e) {
      print("Error liking/unliking post: $e");
    }
  }

  Future<void> postComment(
    int feedId,
    String comment,
    BuildContext context,
    int categoryId,
  ) async {
    _setLoadingComment(feedId, true);

    try {
      Response response = await FeedsApi.postComment(context, feedId, comment);
      CommentsByFeeds newComment = CommentsByFeeds.fromJson(
        response.data['comment'],
      );

      _updateFeed(categoryId, feedId, (feed) {
        List<CommentsByFeeds> updatedComments = List.from(feed.comments ?? [])
          ..add(newComment);
        return feed.copyWith(comments: updatedComments);
      });
    } catch (e) {
      print("Error posting comment: $e");
    }

    _setLoadingComment(feedId, false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setLoadingComment(int feedId, bool value) {
    _isLoadingCommentPerFeed[feedId] = value;
    notifyListeners();
  }

  void _updateFeed(
    int categoryId,
    int feedId,
    DataByFeed Function(DataByFeed) update,
  ) {
    final index =
        _feedsPerCategory[categoryId]?.indexWhere(
          (feed) => feed.id == feedId,
        ) ??
        -1;
    if (index != -1) {
      _feedsPerCategory[categoryId]![index] = update(
        _feedsPerCategory[categoryId]![index],
      );
      notifyListeners();
    }
  }
}
