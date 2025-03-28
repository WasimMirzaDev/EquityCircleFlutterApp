import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

void eventCalenderDetailsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.lightGreyColor,
                  width: 0.28,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Image.asset(
                              Assets.cryptoImg,
                              fit:
                                  BoxFit
                                      .cover, // Makes image fit the card properly
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
                            right: 8,
                            // bottom: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
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
                                        "Public",
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: CircleAvatar(
                                    radius: 12.r,
                                    backgroundColor: AppColors.white,
                                    child: SvgPicture.asset(
                                      Assets.close,
                                      height: 8.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    2.heightBox,
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
                      "Tech Innovation Meetup",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.inter,
                        color: AppColors.black,
                      ),
                    ),
                    2.heightBox,
                    Text(
                      "Exploring the Future of AI and Blockchain",
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.inter,
                        color: AppColors.black,
                      ),
                    ),
                    10.heightBox,
                    Text(
                      "Join industry leaders and experts for an in-depth discussion on how AI and blockchain technology are shaping the future. Discover new trends, network with professionals, and gain valuable insights!",
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.inter,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    12.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: organizorContainer(
                            Assets.user,
                            "Organizer",
                            "View Details",
                          ),
                        ),
                        5.widthBox,
                        Expanded(
                          child: organizorContainer(
                            Assets.calendar,
                            "Date",
                            "March 25, 2025",
                          ),
                        ),
                        5.widthBox,
                        Expanded(
                          child: organizorContainer(
                            Assets.clock,
                            "Time",
                            "10:00 AM - 2:00 PM",
                          ),
                        ),
                      ],
                    ),
                    20.heightBox,
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Container organizorContainer(String icon, String title, String value) {
  return Container(
    // height: 36.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.r),
      color: AppColors.extralightgrey,
    ),
    child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 10.h,
              width: 10.w,
              color: AppColors.black,
            ),
            5.widthBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.inter,
                    color: AppColors.darkGrey,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.inter,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildInfoField(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.inter,
          color: AppColors.blackGrey,
        ),
      ),
      6.heightBox,
      Container(
        height: 32.h,
        width: double.infinity,

        decoration: BoxDecoration(
          color: AppColors.extralightgrey,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.inter,
                color: AppColors.blackGrey,
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
    ],
  );
}
