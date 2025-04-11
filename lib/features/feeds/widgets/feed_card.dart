import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/models/feeds_model.dart';
import 'package:equitycircle/core/providers/feeds_provider.dart';
import 'package:equitycircle/features/bussiness/presentation/widgets/custom_post_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/appFonts.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/theme_colors.dart';
import '../../../core/providers/auth_provider.dart';
import 'comment_InputBar.dart';

class FeedCard extends StatefulWidget {
  final DataByFeed feed;
  final int? loggedInUserId;

  const FeedCard({super.key, required this.feed, this.loggedInUserId});

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _checkAdminStatus();
  }

  // Call to check if the user is an admin
  Future<void> _checkAdminStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool isAdmin = await authProvider.checkAdmin(context);
    setState(() {
      _isAdmin = isAdmin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<MediaByFeeds> media = widget.feed.media ?? [];
    final List<LikesByFeeds> likes = widget.feed.likes ?? [];
    final List<CommentsByFeeds> comments = widget.feed.comments ?? [];
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bool isLiked = likes.any(
      (like) => like.userId == widget.loggedInUserId,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: customPostContainer(
        widget.feed,
        widget.feed.id ?? 0,
        widget.feed.categoryId ?? 0,
        widget.feed.user?.profileImage ?? '',
        widget.feed.user?.name ?? 'Unknown',
        _formatDateTime(widget.feed.createdAt),
        widget.feed.description ?? '',
        () => showCommentsBottomSheet(context, comments),
        () {
          Provider.of<FeedsProvider>(context, listen: false)
              .likeFeed(
                widget.feed.id ?? 0,
                context,
                widget.feed.categoryId ?? 0,
              )
              .then((response) => response);
        },
        _getCategoryName(widget.feed.categoryId ?? 0),
        _getColor(widget.feed.categoryId ?? 0, true, isDarkMode),
        _getColor(widget.feed.categoryId ?? 0, false, isDarkMode),
        media.where((e) => e.url != null && e.url!.isNotEmpty).toList(),

        context,
        likes,
        isLiked,
        comments,
        _isAdmin,
      ),
    );
  }

  Color _getColor(int categoryId, bool isLight, bool isDarkMode) {
    switch (categoryId) {
      case 1:
        return isLight
            ? isDarkMode
                ? AppColors.blackGreyDark
                : AppColors.lightpurple
            : isDarkMode
            ? AppColors.lightpurple
            : AppColors.purpleColor;
      case 2:
        return isLight
            ? isDarkMode
                ? AppColors.blackGreyDark
                : AppColors.lightGreen
            : isDarkMode
            ? AppColors.lightGreen
            : AppColors.green;
      case 3:
        return isLight
            ? isDarkMode
                ? AppColors.blackGreyDark
                : AppColors.lightYellow
            : isDarkMode
            ? AppColors.lightYellow
            : AppColors.yellow;
      case 5:
        return isLight
            ? isDarkMode
                ? AppColors.blackGreyDark
                : AppColors.lightPink
            : isDarkMode
            ? AppColors.lightPink
            : AppColors.darkPink;
      default:
        return Colors.transparent;
    }
  }

  String _formatDateTime(String? dateString) {
    if (dateString == null) return "Unknown Date";
    try {
      DateTime dateTime = DateTime.parse(dateString);
      DateTime now = DateTime.now();
      if (dateTime.year == now.year &&
          dateTime.month == now.month &&
          dateTime.day == now.day) {
        return "Today at ${DateFormat.jm().format(dateTime)}";
      } else {
        return DateFormat('MMM d, yyyy h:mm a').format(dateTime);
      }
    } catch (e) {
      return "Invalid Date";
    }
  }

  String _getCategoryName(int? categoryId) {
    switch (categoryId) {
      case 1:
        return "Business";
      case 2:
        return "Fitness";
      case 3:
        return "Crypto";
      case 5:
        return "Mindset";
      default:
        return "General";
    }
  }

  void showCommentsBottomSheet(
    BuildContext context,
    List<CommentsByFeeds> comments,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder:
                (_, scrollController) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.background(context),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        20.heightBox,
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                Assets.close,
                                height: 12.h,
                                color: ThemeColors.iconColor(context),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Comments",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: AppFonts.inter,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.textColor(context),
                          ),
                        ),
                        20.heightBox,
                        Divider(
                          color: ThemeColors.borderColor(context),
                          height: 0.5.h,
                        ),
                        20.heightBox,

                        // Comments ListView
                        Expanded(
                          child:
                              comments.isEmpty
                                  ? Center(
                                    child: Text(
                                      'No comments found',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: AppFonts.inter,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeColors.textColor(context),
                                      ),
                                    ),
                                  )
                                  : ListView.builder(
                                    controller: scrollController,
                                    itemCount: comments.length,
                                    itemBuilder: (context, index) {
                                      final comment =
                                          comments.reversed.toList()[index];
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            comment.user?.profileImage ?? '',
                                          ),
                                        ),
                                        title: Text(
                                          comment.user?.name ?? 'Anonymous',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: AppFonts.inter,
                                            fontWeight: FontWeight.w600,
                                            color: ThemeColors.textColor(
                                              context,
                                            ),
                                          ),
                                        ),
                                        subtitle: Text(
                                          comment.content ?? '',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: AppFonts.inter,
                                            fontWeight: FontWeight.w600,
                                            color: ThemeColors.textColor(
                                              context,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                        ),

                        20.heightBox,

                        // Ensure the input bar stays at the bottom
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: CommentInputBar(
                            feedId: widget.feed.id ?? 0,
                            categoryId: widget.feed.categoryId ?? 0,
                          ),
                        ),
                        20.heightBox,
                      ],
                    ),
                  ),
                ),
          ),
    );
  }
}
