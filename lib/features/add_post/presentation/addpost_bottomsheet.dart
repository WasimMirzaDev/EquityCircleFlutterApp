import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/features/add_post/presentation/create_event_screen.dart';
import 'package:equitycircle/features/add_post/presentation/create_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'create_job_screen.dart';

void showPostOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            12.heightBox,
            Center(
              child: Container(
                height: 4.h,
                width: 42.w,
                decoration: BoxDecoration(
                  color: AppColors.lightGreyColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close, color: AppColors.black),
              ),
            ),
            6.heightBox,
            Text(
              "Select post type",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.inter,
                color: AppColors.black,
              ),
            ),
            16.heightBox,
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 2.4,
              ),
              children: [
                _buildOption(
                  imgUrl: Assets.photoIcon,
                  label: "Post a photo",
                  color: AppColors.skyBlue,
                  textColor: AppColors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePostScreen(),
                      ),
                    );
                  },
                ),
                _buildOption(
                  imgUrl: Assets.videoIcon,
                  label: "Post a video",
                  color: AppColors.seeGreen,
                  textColor: AppColors.green,
                  onTap: () {},
                ),
                _buildOption(
                  imgUrl: Assets.createJobIcon,
                  label: "Create job",
                  color: AppColors.lightorange,
                  textColor: AppColors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateJobScreen(),
                      ),
                    );
                  },
                ),
                _buildOption(
                  imgUrl: Assets.createEvent,
                  label: "Create event",
                  color: AppColors.lightRed,
                  textColor: AppColors.darkRed,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateEventScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            30.heightBox,
          ],
        ),
      );
    },
  );
}

Widget _buildOption({
  required String imgUrl,
  required String label,
  required Color color,
  required Color textColor,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.r),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(imgUrl),
          8.heightBox,
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontFamily: AppFonts.inter,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    ),
  );
}
