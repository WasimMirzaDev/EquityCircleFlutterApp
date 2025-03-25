import 'package:cached_network_image/cached_network_image.dart';
import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/models/feeds_model.dart';
import 'package:equitycircle/core/widgets/loading_indicator.dart'
    show LoadingIndicator;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MediaGrid extends StatefulWidget {
  List<MediaByFeeds> media;

  MediaGrid({super.key, required this.media});

  @override
  State<MediaGrid> createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Carousel Slider
        SizedBox(
          height: 200, // Adjust height as needed
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.media.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.media[index].url ?? "",
                  placeholder:
                      (context, url) => Center(
                        child: LoadingIndicator(
                          radius: 15,
                          activeColor: AppColors.purpleColor,
                          inactiveColor: AppColors.greyColor,

                          animationDuration: Duration(milliseconds: 500),
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Icon(Icons.error, size: 20),
                ),
              );
            },
          ),
        ),

        // Carousel Indicator (Above the Image)
        if (widget.media.length > 1)
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: carouselIndicator(widget.media.length, _currentIndex),
          ),

        if (widget.media.length > 1)
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColors.lightBlack.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                "${_currentIndex + 1}/${widget.media.length}",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12.sp,

                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget carouselIndicator(int itemCount, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: currentIndex == index ? 8 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.r),
            color:
                currentIndex == index ? AppColors.white : AppColors.greyColor,
          ),
        );
      }),
    );
  }
}
