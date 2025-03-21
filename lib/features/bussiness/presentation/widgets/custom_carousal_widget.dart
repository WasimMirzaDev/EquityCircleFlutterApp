import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ✅ Corrected `customCarousalSlider` function
Widget customCarouselSlider(
  List<String> images,
  PageController pageController,
  Function(int) onPageChanged,
  int currentIndex,
) {
  return Column(
    children: [
      SizedBox(
        height: 200,
        width: double.infinity,
        child: PageView.builder(
          controller: pageController,
          itemCount: images.length,
          onPageChanged: onPageChanged,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(images[index], fit: BoxFit.cover),
              ),
            );
          },
        ),
      ),
      8.heightBox,
      if (images.length > 1) carouselIndicator(images.length, currentIndex),
    ],
  );
}

Widget carouselIndicator(int itemCount, int currentIndex) {
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
                  ? AppColors.purpleColor
                  : AppColors.greyColor,
        ),
      );
    }),
  );
}
