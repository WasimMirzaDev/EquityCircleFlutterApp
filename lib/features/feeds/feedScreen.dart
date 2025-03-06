import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final List<String> carouselImages = [
    'assets/images/logo_icons/carousel.png',
    'assets/images/logo_icons/carousel.png',
    'assets/images/logo_icons/carousel.png',
  ];

  int currentIndex = 0;

  final List<Map<String, dynamic>> posts = [
    {
      "username": "Areesha Haider",
      "profileImage": "assets/images/p2.png",
      "time": "Today at 10:20 pm",
      "category": "Business",
      "content": "Spend less time on testing .......",
      "postImages": [
        "assets/images/postImage.png",
        "assets/images/ima1.png",
        "assets/images/postImage.png",
        "assets/images/postImage.png",
      ],

      "likes": "12,900",
    },
    {
      "username": "Amna",
      "profileImage": "assets/images/p2.png",
      "time": "Today at 10:20 pm",
      "category": "Business",
      "content": "Spend less time on testing .......",
      "postImages": ["assets/images/postImage.png"],
      "likes": "12,900",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEBEAF0),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: Colors.black),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_icons/Equity_Circle_full.png',
              height: 20,
            ),

            Text(
              "Equity Circle",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(backgroundImage: AssetImage('assets/images/p1.png')),
          SizedBox(width: 10),
        ],
      ),
      backgroundColor: Color(0xFFEBEAF0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SizedBox(
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search for users",
                    hintStyle: TextStyle(height: 1.5),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items:
                  carouselImages.map((item) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(item),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
            ),
            SizedBox(height: 10),
            CarouselIndicator(),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return buildPost(context, posts[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget CarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(carouselImages.length, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color:
                currentIndex == index ? Colors.purple : Colors.purple.shade100,
            borderRadius: BorderRadius.circular(8),
            boxShadow:
                currentIndex == index
                    ? [BoxShadow(color: Colors.purple.shade200, blurRadius: 4)]
                    : [],
          ),
        );
      }),
    );
  }

  Widget buildPost(BuildContext context, Map<String, dynamic> post) {
    List<String>? postImages =
        (post['postImages'] as List?)?.cast<String>(); // ✅ Ensure list or null

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(post['profileImage']),
              ),
              title: Text(
                post['username'],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                post['time'],
                style: TextStyle(color: Colors.black45, fontSize: 10),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                post['content'],
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 10),

            /// ✅ Image Gallery (Handles 1, multiple, or no images)
            buildImageGallery(context, postImages),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 12),
                      Icon(Icons.mode_comment_outlined),
                      SizedBox(width: 12),
                      Icon(Icons.send),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${post['likes']} Likes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Function to Show Image Gallery (1 or More Images)
  Widget buildImageGallery(BuildContext context, List<String>? images) {
    if (images == null || images.isEmpty) {
      return SizedBox(); // ✅ Handle no images
    }

    if (images.length == 1) {
      // ✅ If only 1 image, show it normally
      return GestureDetector(
        onTap: () => openFullScreenGallery(context, images, 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              images[0],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250, // Adjust height for single image
            ),
          ),
        ),
      );
    }

    // ✅ If multiple images, show them in a grid
    return GestureDetector(
      onTap: () => openFullScreenGallery(context, images, 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                images.length > 1 ? 2 : 1, // 2 columns if more than 1 image
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: images.length > 4 ? 4 : images.length, // Show max 4 images
          itemBuilder: (context, index) {
            if (index == 3 && images.length > 4) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(images[index], fit: BoxFit.cover),
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: Text(
                        "+${images.length - 4}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Image.asset(images[index], fit: BoxFit.cover);
          },
        ),
      ),
    );
  }

  /// ✅ Open Full-Screen Gallery Function
  void openFullScreenGallery(
    BuildContext context,
    List<String> images,
    int initialIndex,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) =>
                FullScreenGallery(images: images, initialIndex: initialIndex),
      ),
    );
  }
}

class FullScreenGallery extends StatelessWidget {
  final List<String> images;

  const FullScreenGallery({
    super.key,
    required this.images,
    required int initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: AssetImage(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(color: Colors.black),
      ),
    );
  }
}
