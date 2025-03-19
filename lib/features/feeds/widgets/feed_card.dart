import 'package:equitycircle/core/providers/feeds_provider.dart';
import 'package:equitycircle/features/feeds/helpers/picture_helpers.dart';
import 'package:equitycircle/features/feeds/widgets/comment_InputBar.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:equitycircle/features/feeds/widgets/media_grid.dart';
import 'package:flutter/material.dart';
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

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                getProfileImageUrl(widget.feed['user']),
              ),
            ),
            title: Text(
              widget.feed['user']['name'],
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            subtitle: Text(
              DateFormat.jm().format(DateTime.parse(widget.feed['created_at'])),
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ),

          // Post Content
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.feed['title'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              htmlParser
                      .parse(widget.feed['description'] ?? '')
                      .documentElement
                      ?.text ??
                  '',
            ),
          ),
          if (media.isNotEmpty) const SizedBox(height: 10),
          if (media.isNotEmpty) MediaGrid(media: media),

          // Like, Comment & Share Icons
          Row(
            children: [
              // Like Button
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  Provider.of<FeedsProvider>(context, listen: false)
                      .likeFeed(
                        widget.feed['id'],
                        context,
                        widget.feed['category_id'],
                      )
                      .then((response) {
                        response;
                      });
                },
              ),
              Text("${likes.length}"),

              // Comment Button
              IconButton(
                icon: const Icon(Icons.comment, color: Colors.grey),
                onPressed: () => _showCommentsBottomSheet(context, comments),
              ),
              Text("${comments.length}"),

              // Share Button
              IconButton(
                icon: const Icon(Icons.share, color: Colors.grey),
                onPressed: () {
                  // TODO: Handle share action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCommentsBottomSheet(BuildContext context, List<dynamic> comments) {
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
