import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/assets.dart' show Assets;
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/features/bussiness/presentation/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bussiness/presentation/widgets/custom_carousal_widget.dart';
import '../../bussiness/presentation/widgets/custom_post_container.dart';

class FitnessScreen extends StatefulWidget {
  final int categoryId;
  const FitnessScreen({super.key, required this.categoryId});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  final TextEditingController searchController = TextEditingController();

  final PageController _pageController = PageController();
  int currentIndex = 0;

  List<String> images = [
    Assets.fitnessImg,
    Assets.carousalImg,
    Assets.mindsetImg,
    Assets.cryptoImg,
  ];
  final List<Map<String, dynamic>> posts = [
    {
      "imageUrl":
          "https://images.unsplash.com/photo-1423479185712-25d4a4fe1006?q=80&w=2676&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "author": "Jerome Bell",
      "time": "Today at 10:12 pm",
      "content":
          """"Push yourself because no one else is going to do it for you." 💪
"Consistency is what transforms average into excellence." 🔥
"Sweat today, shine tomorrow." ✨
"Push yourself because no one else is going to do it for you." 💪
"Consistency is what transforms average into excellence." 🔥
"Sweat today, shine tomorrow." ✨""",
      "category": "Fitness",
      "lightColor": AppColors.lightGreen,
      "darkColor": AppColors.green,
      "attachments": [],
      "is_liked": true,
      "likes": [
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        1,
        1,
        2,
        2,
        2,

        3,
        3,
        1,
        1,
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        3,
        3,
        1,
        1,
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        1,
        1,
      ],
      "comments": [3, 3, 1, 1, 2, 2, 2, 3, 3, 1, 2, 2, 2, 3, 3, 3, 3, 1, 1],
    },
    {
      "imageUrl":
          "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?q=80&w=2676&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "author": "Brooklyn Simmons",
      "time": "Yesterday at 5:00 pm",
      "content":
          """"Push yourself because no one else is going to do it for you." 💪
"Consistency is what transforms average into excellence." 🔥
"Sweat today, shine tomorrow." ✨""",
      "category": "Fitness",
      "lightColor": AppColors.lightGreen,
      "darkColor": AppColors.green,
      "attachments": [
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/a306/d8a8/8be021d3f99c2f21b2011d6fb1fd2dfc?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=iKx3xE3snUv6EGe37U6A9F1WsEXs68ADYw0Xg5-oD4uHZn6p9YTY2A8JyV24Bc9p5AHi584To7EWCgA1fa-lRAOyrX9JVo9Q~YlsjI5FFtoCGPKv9vgi8QcBe3t3zKvSzN0O2OPF~x1qVGWBGLpCc8xaYmFFbMOkXmUhzBaXdKBYvjR4~xllPDomsvRF7M8c20DZF19pZ-eqeSBNexeYS-lrx5M3YzAcMa6hwfptn4wlQwJ3KEQJQZoXV8XGXJeP9XMjuj~ZQGdi~A~TLhw2n69hevsR~ecPGPGgdbS-b3qGcubZQD7EQeU4XtEW0SkClORrHBlTh4SkRMw2zv7SuA__',
        },
      ],
      "is_liked": false,
      "likes": [2, 2, 3, 3, 3, 1, 1],
      "comments": [1, 1],
    },
    {
      "imageUrl":
          "https://s3-alpha-sig.figma.com/img/1e83/2cd5/96aa7da2d61d5f318e6fe73ff4f2a059?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=fmdXWnKKyVldZU5yxAjRnEUwsDX9KQQ0keRjgIt1Cte7y4jTy3PIbmXrhRIISTQp4H1LPEiAhbfd7AUBYl~7WYyCiMKrmu5mBx8s8D9cO2qh-Ir-x7lrWyNErjjUDePE2ZaJSwNKkyjMTehaJL4WidlG5XkHCGBi2xZ48MMGOVtXnltrza69wyJHIW97T0wJIGLxt3gZUd6RFwLrJkX~SB9XGes5jXSlsrINgiosrY4WR7d5viDFzEK43yw9xPM6KUYy~KOC2~422P608xgx0kz93pftIxDroC5MCKIZM9OJlNwc-xfmBzC-~lR6ROtGXsL6E-twrX6mRD3-wt5x9g__",
      "author": "Alice Smith",
      "time": "2 days ago",
      "content":
          """"Push yourself because no one else is going to do it for you." 💪
"Consistency is what transforms average into excellence." 🔥
"Sweat today, shine tomorrow." ✨""",
      "category": "Fitness",
      "lightColor": AppColors.lightGreen,
      "darkColor": AppColors.green,
      "attachments": [
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/e6da/abf1/e35f04b5f024fe8b3e7a7d6c8d4b78b8?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=RQ~iohuC-dDDgetYJ7wOO1MOm2DhQyhvKyBj7iAnBEn6C30-y8rqqcrThK3jqAyDpEbBPlcljoRAgfZWVV2eAY17eCFcvNz7~ezMjVvhX5jZgrDgUMMLb1sNj9fwEWnyjhTXKoTTO26VxMeJ2fnUTeNnYy0SGx~rBa3pkvLvHSvlOAohf0LtK99IDvWDIbDAOrEFe0MX4MMhBTjehBKTu9PYyfq6uu57vfzHHKmOaGP0gLwY5Z5xQulqq0pDXKaCBEpbzbS8I6vFhnq22pwk0vuU07fOOWSFsDlxfhq0N~VwrBaPZQxldczyN1gX3X2CYoTr~QW-2thWqcXknGcxBg__',
        },
        {
          "url":
              'https://equity-api.techtrack.online/data/images/1738787948_sporty-motivated-handsome-man-leans-and-does-sport-exercises-poses-outdoor-and-busy-doing-workout-determined-shirtless-guy-wears-sneakers-has-morning-training-in-park-healthy-lifestyle-concept-photo.jpeg',
        },
        {
          "url":
              'https://equity-api.techtrack.online/data/images/1738787602__7b5e3c6c-402d-11eb-846d-e0066b9df566.jpg',
        },
        {
          "url":
              'https://equity-api.techtrack.online/data/images/1738787602_man-2604149_1280.jpg',
        },
      ],
      "is_liked": true,
      "likes": [
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        1,
        1,
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        3,
        3,
        3,
        1,
        1,
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        3,
        3,
        3,
        1,
        1,
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        1,
        1,
      ],
      "comments": [3, 3, 3, 1, 1],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
        child: Column(
          children: [
            20.heightBox,

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  customeSearchWidget("   Search for users", searchController),
                  12.heightBox,
                  customCarousalSlider(
                    images,
                    _pageController,
                    (index) => setState(() => currentIndex = index),
                    currentIndex,
                  ),
                  20.heightBox,
                  ...posts.map((post) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: customPostContainer(
                        post["imageUrl"],
                        post["author"],
                        post["time"],
                        post["content"],
                        () {},
                        () {},
                        post["category"],
                        post["lightColor"],
                        post["darkColor"],
                        post["attachments"],
                        context,
                        post["likes"],
                        post["is_liked"],
                        post["comments"],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
