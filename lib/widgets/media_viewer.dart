import 'package:flutter/material.dart';

class MediaViewer extends StatelessWidget {
  final List<dynamic> media;
  const MediaViewer({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Media Gallery")),
      body: PageView.builder(
        itemCount: media.length,
        itemBuilder: (context, index) {
          return Center(child: Image.network(media[index]['url']));
        },
      ),
    );
  }
}
