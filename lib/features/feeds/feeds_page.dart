import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/core/providers/feeds_provider.dart';
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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final provider = Provider.of<FeedsProvider>(context, listen: false);

      // ✅ Fetch data only if it hasn't been loaded yet
      if (provider.getFeedsByCategory(widget.categoryId).isEmpty) {
        provider.fetchFeeds(context, categoryId: widget.categoryId);
      }
    });
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
                child: CircularProgressIndicator(),
              ) // ✅ Show loader only if empty
              : RefreshIndicator(
                onRefresh: () async {
                  await feedsProvider.fetchFeeds(
                    context,
                    categoryId: widget.categoryId,
                    refresh: true,
                  );
                },
                child: ListView.builder(
                  itemCount: feeds.length,
                  itemBuilder: (context, index) {
                    return FeedCard(
                      feed: feeds[index],
                      loggedInUserId:
                          Provider.of<AuthProvider>(context).userData!['id'],
                    );
                  },
                ),
              ),
    );
  }
}
