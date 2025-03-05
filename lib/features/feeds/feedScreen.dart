import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
      "postImage": "assets/images/postImage.png",
      "likes": "12,900",
    },
    {
      "username": "Amna",
      "profileImage": "assets/images/p2.png",
      "time": "Today at 10:20 pm",
      "category": "Business",
      "content": "Spend less time on testing .......",
      "postImage": "assets/images/postImage.png",
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
                return buildPost(posts[index]);
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

  Widget buildPost(Map<String, dynamic> post) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 80,
                    child: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      visualDensity: VisualDensity.compact,
                      label: FittedBox(
                        child: Text(
                          post['category'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(255, 180, 122, 191),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  Icon(Icons.more_vert, color: Colors.grey),
                ],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  post['postImage'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ),
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

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Write a comment",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Icon(Icons.attach_file, color: Colors.grey),
                    SizedBox(width: 8),
                    Icon(Icons.camera_alt, color: Colors.grey),
                    SizedBox(width: 8),
                    Icon(Icons.emoji_emotions, color: Colors.grey),
                    SizedBox(width: 8),
                    Icon(Icons.send, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
