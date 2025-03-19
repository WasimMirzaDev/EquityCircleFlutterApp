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
                        "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?q=80&w=2585&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        "Areesha Haider",
                        "Today at 10:20 pm",

                        'Fitness is the state of being physically and mentally healthy through regular exercise, proper nutrition, and an active lifestyle. It improves strength, endurance, flexibility, and overall well-being.',
                        () {},
                        () {},
                        "Fitness",

                        AppColors.lightGreen,
                        AppColors.green,
                        [
                          {
                            "url":
                                'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          }, // Example static image
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
