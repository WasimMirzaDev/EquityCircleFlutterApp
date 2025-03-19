import 'package:carousel_slider/carousel_slider.dart';
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool isSearhing = false;
  TextEditingController searchController = TextEditingController();

  final List<String> carouselImages = [
    'assets/images/c1.png',
    'assets/images/c2.png',
    'assets/images/c3.jpg',
  ];

  int currentIndex = 0;
  int curr = 0;

  final List<Map<String, dynamic>> posts = [
    {
      "username": "Areesha Haider",
      "profileImage": "assets/images/p2.png",
      "time": "Today at 10:20 pm",
      "category": "Business",
      "content": "Spend less time on testing .......",
      "postImages": [
        "assets/images/front.png",
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
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,

        title:
            isSearhing
                ? TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                  style: TextStyle(color: Colors.black),
                )
                : null,

        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearhing = !isSearhing;
                if (!isSearhing) {
                  searchController.clear();
                }
              });
            },
            icon: Icon(
              isSearhing ? Icons.close : Icons.search,
              color: Colors.black,
            ),
          ),
          CircleAvatar(backgroundImage: AssetImage('assets/images/p1.png')),
          SizedBox(width: 10),
        ],
      ),

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: TextStyle(
                  fontFamily: AppFonts.inter,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1E1E),
                ),
                child: Text("Upcoming Events"),
              ),

              SizedBox(height: 5),
              CarouselSlider(
                options: CarouselOptions(
                  height: 206,

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
                      return Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(item),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 40,
                            //right: 20,
                            child: Container(
                              height: 37,
                              width: 191,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(30),
                              ),

                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text(
                                      'View All',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    right: 2,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 19,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
              ),
              SizedBox(height: 2),
              CarouselIndicator(carouselImages.length, currentIndex),
              DefaultTextStyle(
                style: TextStyle(
                  fontFamily: AppFonts.inter,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1E1E),
                ),
                child: Text("Posts"),
              ),

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
      ),
    );
  }

  Widget CarouselIndicator(int itemCount, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: currentIndex == index ? Colors.black87 : Colors.grey[400],
          ),
        );
      }),
    );
  }

  Widget buildPost(BuildContext context, Map<String, dynamic> post) {
    List<String>? postImages = (post['postImages'] as List?)?.cast<String>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: Color(0xFFF5F2F2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(post['profileImage']),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      post['username'],
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E1E1E),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 10), // Space between name and chip
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(137, 106, 255, 0.94),
                          Color.fromRGBO(154, 106, 252, 1),
                          Color.fromRGBO(154, 106, 252, 1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.9, 0.9],
                      ),
                    ),
                    child: Text(
                      'Business',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                post['time'],
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1E1E1E),
                ),
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
            buildImageGallery(context, postImages),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo_icons/heart.png',
                        width: 20,
                        height: 20,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 12),
                      Image.asset(
                        'assets/images/logo_icons/comment.png',
                        width: 20,
                        height: 20,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 12),
                      Image.asset(
                        'assets/images/logo_icons/share.png',
                        width: 20,
                        height: 20,
                        color: Colors.black87,
                      ),
                    ],
                  ),

                  SizedBox(height: 5),
                  Text(
                    "${post['likes']} Likes",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,

                      fontSize: 12,
                      color: Colors.black87,
                      height: 20 / 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Write a comment",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.attach_file,
                                size: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.grey,
                              ),

                              SizedBox(width: 8),
                              Icon(
                                Icons.emoji_emotions_outlined,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.send, size: 22, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildImageGallery(BuildContext context, List<String>? images) {
    if (images == null || images.isEmpty) return const SizedBox();

    return Column(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                curr = index;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => openFullScreenGallery(context, images, index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Stack(
                    alignment:
                        Alignment.bottomCenter, // Aligns items at the bottom
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 26,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.more_horiz,
                              color: Color(0xFF896AFF),
                              size: 18,
                            ),
                          ),
                        ),
                      ),

                      if (images.length > 1)
                        Positioned(
                          bottom: 10, // Moves indicator inside the image
                          child: CarouselIndicator(images.length, curr),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

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
