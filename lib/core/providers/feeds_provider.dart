import 'package:flutter/material.dart';
import '../api/feeds_api.dart';
import 'package:dio/dio.dart';

class FeedsProvider with ChangeNotifier {
  final Map<int, List<Map<String, dynamic>>> _feedsPerCategory = {};
  final Map<int, bool> _hasMorePerCategory = {};
  final Map<int, int> _currentPagePerCategory = {};
  bool _isLoading = false;
  bool _isLoadingComment = false;

  bool get isLoading => _isLoading;
  bool get isLoadingComment => _isLoadingComment;

  List<Map<String, dynamic>> getFeedsByCategory(int categoryId) {
    return _feedsPerCategory[categoryId] ?? [];
  }

  bool hasMore(int categoryId) {
    return _hasMorePerCategory[categoryId] ?? true;
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

    _isLoading = true;
    notifyListeners();

    try {
      Response response = await FeedsApi.getFeeds(
        context,
        page: _currentPagePerCategory[categoryId]!,
        category_id: categoryId,
      );

      List<Map<String, dynamic>> newFeeds = List<Map<String, dynamic>>.from(
        response.data['data'],
      );

      _hasMorePerCategory[categoryId] = response.data['has_more'];

      if (loadMore) {
        _feedsPerCategory[categoryId]!.addAll(newFeeds);
      } else {
        _feedsPerCategory[categoryId] = newFeeds;
      }

      _currentPagePerCategory[categoryId] = response.data['current_page'] + 1;
    } catch (e) {
      print("Error fetching feeds: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> likeFeed(
    int feedId,
    BuildContext context,
    int categoryId,
  ) async {
    try {
      Response response = await FeedsApi.likeFeed(context, feedId);
      if (response.data['success']) {
        final index =
            _feedsPerCategory[categoryId]?.indexWhere(
              (feed) => feed['id'] == feedId,
            ) ??
            -1;
        if (index != -1) {
          _feedsPerCategory[categoryId]![index]['likes'] =
              response.data['likes'];
          _feedsPerCategory[categoryId]![index]['likes_count'] =
              response.data['likes_count'];

          notifyListeners();
        }
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
    try {
      _isLoadingComment = true;
      notifyListeners();
      Response response = await FeedsApi.postComment(context, feedId, comment);
      final index =
          _feedsPerCategory[categoryId]?.indexWhere(
            (feed) => feed['id'] == feedId,
          ) ??
          -1;
      if (index != -1) {
        _feedsPerCategory[categoryId]![index]['comments'] = [
          ...?_feedsPerCategory[categoryId]![index]['comments'],
          response.data['comment'],
        ];
        _feedsPerCategory[categoryId]![index]['comments_count'] =
            _feedsPerCategory[categoryId]![index]['comments'].length;

        notifyListeners();
        _isLoadingComment = false;
      }
    } catch (e) {
      print("Error posting comment: $e");
    }
  }
}
