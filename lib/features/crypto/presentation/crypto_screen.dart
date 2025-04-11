import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/assets.dart' show Assets;
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/providers/auth_provider.dart'
    show AuthProvider;
import 'package:equitycircle/core/widgets/loading_indicator.dart';
import 'package:equitycircle/features/bussiness/presentation/widgets/custom_search_field.dart';
import 'package:equitycircle/features/bussiness/presentation/widgets/not_found_widget.dart';
import 'package:equitycircle/features/feeds/widgets/feed_card.dart'
    show FeedCard;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/theme_colors.dart';
import '../../../core/providers/feeds_provider.dart' show FeedsProvider;
import '../../bussiness/presentation/widgets/custom_carousal_widget.dart';

class CryptoScreen extends StatefulWidget {
  final int categoryId;
  const CryptoScreen({super.key, required this.categoryId});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  late ScrollController _scrollController;
  final TextEditingController searchController = TextEditingController();
  final PageController _pageController = PageController();
  int currentIndex = 0;

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

  List<String> images = [
    Assets.cryptoImg,
    Assets.carousalImg,
    Assets.fitnessImg,
    Assets.mindsetImg,
  ];
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
            icon: Assets.cryptoIcon,
            text:
                "No crypto updates available. Keep an eye out for market trends and insights.",
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: ThemeColors.bottomNavColor(context),
      onRefresh: () async {
        await feedsProvider.fetchFeeds(
          context,
          categoryId: widget.categoryId,
          refresh: true,
        );
      },
      child: Column(
        children: [
          Divider(color: ThemeColors.borderColor(context), thickness: 0.5.h),
          20.heightBox,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
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
          ),
        ],
      ),
    );
  }
}
