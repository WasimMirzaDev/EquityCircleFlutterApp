import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/core/providers/feeds_provider.dart';
import 'package:equitycircle/core/widgets/loading_indicator.dart'
    show LoadingIndicator;
import 'package:equitycircle/features/feeds/widgets/feed_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedsPage extends StatefulWidget {
  final int categoryId;
  const FeedsPage({super.key, required this.categoryId});

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  late ScrollController _scrollController; // ✅ Declare it here

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(); // ✅ Initialize it first
    _scrollController.addListener(_scrollListener); // ✅ Then add the listener

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FeedsProvider>(context, listen: false);
      if (provider.getFeedsByCategory(widget.categoryId).isEmpty) {
        provider.fetchFeeds(context, categoryId: widget.categoryId);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // ✅ Always dispose of the controller
    super.dispose();
  }

  void _scrollListener() {
    final provider = Provider.of<FeedsProvider>(context, listen: false);
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        provider.hasMore(widget.categoryId) &&
        !provider.isLoading) {
      provider.fetchFeeds(
        context,
        categoryId: widget.categoryId,
        loadMore: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final feedsProvider = Provider.of<FeedsProvider>(context);
    final feeds = feedsProvider.getFeedsByCategory(widget.categoryId);
    final isLoading = feedsProvider.isLoading;

    return Scaffold(
      body:
          isLoading && feeds.isEmpty
              ? Center(
                child: LoadingIndicator(
                  radius: 15,
                  activeColor: AppColors.purpleColor,
                  inactiveColor: AppColors.greyColor,

                  animationDuration: Duration(milliseconds: 500),
                ),
              )
              : RefreshIndicator(
                onRefresh: () async {
                  await feedsProvider.fetchFeeds(
                    context,
                    categoryId: widget.categoryId,
                    refresh: true,
                  );
                },
                child: ListView.builder(
                  controller: _scrollController, // ✅ Attach scroll controller
                  itemCount: feeds.length + 1, // ✅ Add extra item for loader
                  itemBuilder: (context, index) {
                    if (index < feeds.length &&
                        Provider.of<AuthProvider>(context).isAuthenticated) {
                      return FeedCard(
                        feed: feeds[index],
                        loggedInUserId:
                            Provider.of<AuthProvider>(context).userData!['id'],
                      );
                    } else if (feedsProvider.hasMore(widget.categoryId)) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: LoadingIndicator(
                            radius: 15,
                            activeColor: AppColors.purpleColor,
                            inactiveColor: AppColors.greyColor,

                            animationDuration: Duration(milliseconds: 500),
                          ),
                        ),
                      );
                    }
                    return SizedBox(); // ✅ No more items to load
                  },
                ),
              ),
    );
  }
}
