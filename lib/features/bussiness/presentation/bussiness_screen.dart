import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/assets.dart' show Assets;
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/core/providers/feeds_provider.dart';
import 'package:equitycircle/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/theme_colors.dart';
import '../../feeds/widgets/feed_card.dart';
import 'widgets/custom_carousal_widget.dart';
import 'widgets/custom_search_field.dart';
import 'widgets/not_found_widget.dart';

class BusinessScreen extends StatefulWidget {
  final int categoryId;
  const BusinessScreen({super.key, required this.categoryId});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  late ScrollController _scrollController;
  final TextEditingController searchController = TextEditingController();
  int currentIndex = 0;

  List<String> images = [
    Assets.carousalImg,
    Assets.cryptoImg,
    Assets.fitnessImg,
    Assets.mindsetImg,
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FeedsProvider>(context, listen: false);
      if (provider.getFeedsByCategory(widget.categoryId).isEmpty) {
        provider.fetchFeeds(context, categoryId: widget.categoryId);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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

    if (isLoading && feeds.isEmpty) {
      return Center(
        child: LoadingIndicator(
          radius: 15,
          activeColor: ThemeColors.indicatorColor(context),
          inactiveColor: AppColors.greyColor,
          animationDuration: const Duration(milliseconds: 500),
        ),
      );
    }

    if (feeds.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: NoBusinessInsights(
            icon: Assets.bussinesIcon,
            text:
                "No business insights available at the moment. Check back later for the latest updates.",
          ),
        ),
      );
    }

    return RefreshIndicator(
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
                  customSearchWidget(
                    "   Search for users",
                    searchController,
                    context,
                  ),
                  12.heightBox,
                  CustomCarouselSlider(images: images),
                  20.heightBox,
                  ...feeds.map(
                    (feed) => FeedCard(
                      feed: feed,
                      loggedInUserId:
                          Provider.of<AuthProvider>(context).userData!['id'],
                    ),
                  ),
                  if (feedsProvider.hasMore(widget.categoryId))
                    Center(
                      child: LoadingIndicator(
                        radius: 15,
                        activeColor: ThemeColors.indicatorColor(context),
                        inactiveColor: AppColors.greyColor,
                        animationDuration: Duration(milliseconds: 500),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
