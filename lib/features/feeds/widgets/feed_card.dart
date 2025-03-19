import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/providers/feeds_provider.dart';
import 'package:equitycircle/features/bussiness/presentation/widgets/custom_post_container.dart';
import 'package:equitycircle/features/feeds/helpers/picture_helpers.dart';
import 'package:equitycircle/features/feeds/widgets/comment_InputBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FeedCard extends StatefulWidget {
  final Map<String, dynamic> feed;
  final int? loggedInUserId; // Pass the logged-in user ID
  const FeedCard({super.key, required this.feed, this.loggedInUserId});

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> media = widget.feed['media'] ?? [];
    final List<dynamic> likes = widget.feed['likes'] ?? [];
    final List<dynamic> comments = widget.feed['comments'] ?? [];
    final bool isLiked = likes.any(
      (like) => like['user_id'] == widget.loggedInUserId,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: customPostContainer(
        getProfileImageUrl(widget.feed['user']),
        widget.feed['user']['name'],
        _formatDateTime(widget.feed['created_at']),
        htmlParser
                .parse(widget.feed['description'] ?? '')
                .documentElement
                ?.text ??
            '',
        () {
          showCommentsBottomSheet(context, comments);
        },
        () {
          Provider.of<FeedsProvider>(context, listen: false)
              .likeFeed(widget.feed['id'], context, widget.feed['category_id'])
              .then((response) {
                response;
              });
        },
        "Business",
        AppColors.lightpurple,
        AppColors.purpleColor,
        media,
        context,
        likes,
        isLiked,
        comments,
      ),
    );
  }

  String _formatDateTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateTime now = DateTime.now();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return "Today at ${DateFormat.jm().format(dateTime)}";
    } else {
      return DateFormat.jm().format(dateTime);
    }
  }

  void showCommentsBottomSheet(BuildContext context, List<dynamic> comments) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.5, // Half screen
            minChildSize: 0.3, // Minimum height
            maxChildSize: 0.9, // Almost full screen
            builder:
                (_, scrollController) => Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Comments",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),

                      const Divider(),
                      CommentInputBar(
                        feedId: widget.feed['id'],
                        categoryId: widget.feed['category_id'],
                      ),
                      const SizedBox(height: 10),

                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment =
                                comments[comments.length - 1 - index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  getProfileImageUrl(comment['user']),
                                ),
                              ),
                              title: Text(comment['user']['name']),
                              subtitle: Text(comment['content']),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }
}
