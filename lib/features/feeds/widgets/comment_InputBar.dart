import 'package:equitycircle/core/providers/feeds_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentInputBar extends StatefulWidget {
  final int feedId;
  final int categoryId;
  const CommentInputBar({
    super.key,
    required this.feedId,
    required this.categoryId,
  });

  @override
  State<CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<CommentInputBar> {
  final TextEditingController textController = TextEditingController();

  void _handleComment() {
    final String comment = textController.text.trim();
    if (comment.isNotEmpty) {
      final int feedId = widget.feedId;

      final FeedsProvider feedsProvider = Provider.of<FeedsProvider>(
        context,
        listen: false,
      );

      feedsProvider.postComment(feedId, comment, context, widget.categoryId);
      textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "Type your comment...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 5),
          // _buildIcon(Icons.gif, () {
          //   // TODO: Handle open gif search action
          // }),
          _buildIcon(Icons.emoji_emotions, () {
            // TODO: Handle open emoji picker action
          }),
          _buildIcon(Icons.image, () {
            // TODO: Handle open gallery action
          }),
          GestureDetector(
            onTap: () {
              _handleComment();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child:
                  Provider.of<FeedsProvider>(context).isLoadingComment
                      ? const CircularProgressIndicator(
                        semanticsLabel: 'Loading...',
                        semanticsValue: 'Loading...',
                        color: Colors.blue,
                        strokeWidth: 2,
                      )
                      : Icon(Icons.send, color: Colors.blue, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Icon(icon, color: Colors.blue, size: 28),
      ),
    );
  }
}
