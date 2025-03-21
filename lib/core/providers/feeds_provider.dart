import 'package:dio/dio.dart';
import 'package:equitycircle/core/models/feeds_model.dart';
import 'package:flutter/material.dart';

import '../api/feeds_api.dart';

class FeedsProvider with ChangeNotifier {
  final Map<int, List<DataByFeed>> _feedsPerCategory = {};
  final Map<int, bool> _hasMorePerCategory = {};
  final Map<int, int> _currentPagePerCategory = {};
  bool _isLoading = false;
  bool _isLoadingComment = false;

  bool get isLoading => _isLoading;
  bool get isLoadingComment => _isLoadingComment;

  List<DataByFeed> getFeedsByCategory(int categoryId) =>
      _feedsPerCategory[categoryId] ?? [];

  bool hasMore(int categoryId) => _hasMorePerCategory[categoryId] ?? true;

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
    _setLoadingComment(true);

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

    _setLoadingComment(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setLoadingComment(bool value) {
    _isLoadingComment = value;
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
