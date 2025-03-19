import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/assets.dart' show Assets;
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/features/bussiness/presentation/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bussiness/presentation/widgets/custom_carousal_widget.dart';
import '../../bussiness/presentation/widgets/custom_post_container.dart';

class MindsetScreen extends StatefulWidget {
  final int categoryId;
  const MindsetScreen({super.key, required this.categoryId});

  @override
  State<MindsetScreen> createState() => _MindsetScreenState();
}

class _MindsetScreenState extends State<MindsetScreen> {
  final TextEditingController searchController = TextEditingController();

  final PageController _pageController = PageController();
  int currentIndex = 0;

  List<String> images = [
    Assets.mindsetImg,
    Assets.cryptoImg,
    Assets.fitnessImg,
    Assets.carousalImg,
  ];
  List<List<Map<String, String>>> mediaLists = [
    [
      {
        "url":
            'https://media.istockphoto.com/id/614012698/photo/i-am-a-strong-woman.jpg?s=1024x1024&w=is&k=20&c=Dahswq7Z71XJqKx2SaNbYA3oByKhk4eot6vuHSSXNZQ=',
      },
      {"url": 'https://example.com/image2.jpg'},
    ],
    [
      {
        "url":
            'https://media.istockphoto.com/id/614012698/photo/i-am-a-strong-woman.jpg?s=1024x1024&w=is&k=20&c=Dahswq7Z71XJqKx2SaNbYA3oByKhk4eot6vuHSSXNZQ=',
      },
      {"url": 'https://example.com/image4.jpg'},
    ],
    [
      {"url": 'https://example.com/image5.jpg'},
      {"url": 'https://example.com/image6.jpg'},
    ],
    [
      {"url": 'https://example.com/image7.jpg'},
      {"url": 'https://example.com/image8.jpg'},
    ],
    [
      {"url": 'https://example.com/image9.jpg'},
      {"url": 'https://example.com/image10.jpg'},
    ],
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
                  ...List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: customPostContainer(
                        "https://images.unsplash.com/photo-1423479185712-25d4a4fe1006?q=80&w=2676&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        "Faryal",
                        "Today at 10:20 pm",

                        'Mindset is a set of beliefs and attitudes that shape how you think, feel, and act. A positive mindset fosters growth, resilience, and success, while a fixed mindset can limit potential.',
                        () {},
                        () {},
                        "Technology",

                        AppColors.lightPink,
                        AppColors.darkPink,
                        [
                          {
                            "url":
                                'https://media.istockphoto.com/id/614012698/photo/i-am-a-strong-woman.jpg?s=1024x1024&w=is&k=20&c=Dahswq7Z71XJqKx2SaNbYA3oByKhk4eot6vuHSSXNZQ=',
                          },
                          {
                            "url":
                                'https://media.istockphoto.com/id/614012698/photo/i-am-a-strong-woman.jpg?s=1024x1024&w=is&k=20&c=Dahswq7Z71XJqKx2SaNbYA3oByKhk4eot6vuHSSXNZQ=',
                          },
                          {
                            "url":
                                'https://media.istockphoto.com/id/614012698/photo/i-am-a-strong-woman.jpg?s=1024x1024&w=is&k=20&c=Dahswq7Z71XJqKx2SaNbYA3oByKhk4eot6vuHSSXNZQ=',
                          },
                          {
                            "url":
                                'https://media.istockphoto.com/id/614012698/photo/i-am-a-strong-woman.jpg?s=1024x1024&w=is&k=20&c=Dahswq7Z71XJqKx2SaNbYA3oByKhk4eot6vuHSSXNZQ=',
                          },
                        ],
                        context,
                        [],
                        true,
                        [],
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
