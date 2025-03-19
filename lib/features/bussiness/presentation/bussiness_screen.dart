import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/assets.dart' show Assets;
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/core/providers/feeds_provider.dart';
import 'package:equitycircle/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feeds/widgets/feed_card.dart';
import 'widgets/custom_carousal_widget.dart';
import 'widgets/custom_search_field.dart';

class BussinessScreen extends StatefulWidget {
  final int categoryId;
  const BussinessScreen({super.key, required this.categoryId});

  @override
  State<BussinessScreen> createState() => _BussinessScreenState();
}

class _BussinessScreenState extends State<BussinessScreen> {
  late ScrollController _scrollController; // ✅ Declare it here
  final TextEditingController searchController = TextEditingController();

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

  final PageController _pageController = PageController();
  int currentIndex = 0; // ✅ Initialize curr index

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

  List<String> images = [
    Assets.carousalImg,
    Assets.cryptoImg,
    Assets.fitnessImg,
    Assets.mindsetImg,
  ];

  @override
  Widget build(BuildContext context) {
    final feedsProvider = Provider.of<FeedsProvider>(context);
    final feeds = feedsProvider.getFeedsByCategory(widget.categoryId);
    final isLoading = feedsProvider.isLoading;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
                  child: Column(
                    children: [
                      20.heightBox,

                      Expanded(
                        child: ListView(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          children: [
                            customeSearchWidget(
                              "   Search for users",
                              searchController,
                            ),
                            12.heightBox,
                            customCarousalSlider(
                              images,
                              _pageController,
                              (index) => setState(() => currentIndex = index),
                              currentIndex,
                            ),
                            20.heightBox,
                            ...feeds.map(
                              (feed) => FeedCard(
                                feed: feed,
                                loggedInUserId:
                                    Provider.of<AuthProvider>(
                                      context,
                                    ).userData!['id'],
                              ),
                            ),
                            if (feedsProvider.hasMore(widget.categoryId))
                              Center(
                                child: LoadingIndicator(
                                  radius: 15,
                                  activeColor: AppColors.purpleColor,
                                  inactiveColor: AppColors.greyColor,

                                  animationDuration: Duration(
                                    milliseconds: 500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
