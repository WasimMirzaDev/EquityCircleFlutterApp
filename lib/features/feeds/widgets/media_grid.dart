import 'package:equitycircle/widgets/media_viewer.dart';
import 'package:flutter/material.dart';

class MediaGrid extends StatelessWidget {
  final List<dynamic> media;
  const MediaGrid({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    int mediaCount = media.length;
    int displayCount = mediaCount > 4 ? 3 : mediaCount;
    bool hasMore = mediaCount > 4;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MediaViewer(media: media)),
        );
      },
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: displayCount + (hasMore ? 1 : 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          if (hasMore && index == displayCount) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.network(media[index]['url'], fit: BoxFit.cover),
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: Text(
                      "+${mediaCount - 4}",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            );
          }
          return Image.network(media[index]['url'], fit: BoxFit.cover);
        },
      ),
    );
  }
}
