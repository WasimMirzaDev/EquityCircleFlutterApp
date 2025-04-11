/// ✅ Corrected `customCarousalSlider` function
library;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/theme_colors.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<String> images;

  const CustomCarouselSlider({super.key, required this.images});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items:
              widget.images.map((image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
          options: CarouselOptions(
            height: 200.h,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        8.heightBox,
        if (widget.images.length > 1)
          carouselIndicator(widget.images.length, _currentIndex, context),
      ],
    );
  }
}

Widget carouselIndicator(
  int itemCount,
  int currentIndex,
  BuildContext context,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(itemCount, (index) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        width: currentIndex == index ? 30.w : 7.w,
        height: 7.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          color:
              currentIndex == index
                  ? ThemeColors.carousalIndicatorColor(context)
                  : AppColors.greyColor,
        ),
      );
    }),
  );
}
