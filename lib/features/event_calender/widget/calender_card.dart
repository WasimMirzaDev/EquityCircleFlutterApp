import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'event_calender_detail_bottomsheet.dart';

class CalenderCardWidget extends StatelessWidget {
  String image;
  String status;
  String title;
  String discription;

  CalenderCardWidget({
    super.key,
    required this.discription,
    required this.status,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.white,
        border: Border.all(color: AppColors.lightGreyColor, width: 0.28),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Makes sure Card wraps content
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover, // Makes image fit the card properly
                      width: double.infinity,
                      height: 170.h,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          size: 100,
                        ); // Fallback if image fails
                      },
                    ),
                  ),

                  Positioned(
                    top: 8,
                    left: 8,
                    // right: 0,
                    // bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56.r),
                        color: AppColors.white,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 5.h,
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFonts.inter,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            5.heightBox,
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56.r),
                    color: AppColors.extralightgrey,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h,
                      ),
                      child: Text(
                        "Conference",
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFonts.inter,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            5.heightBox,
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.inter,
                color: AppColors.black,
              ),
            ),
            2.heightBox,
            Text(
              discription,
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.inter,
                color: AppColors.black,
              ),
            ),

            12.heightBox,
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    eventCalenderDetailsBottomSheet(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: AppColors.purpleColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 5.h,
                        ),
                        child: Text(
                          "View Details",
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFonts.inter,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                10.widthBox,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: AppColors.red,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h,
                      ),
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.inter,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            12.heightBox,
          ],
        ),
      ),
    );
  }
}
