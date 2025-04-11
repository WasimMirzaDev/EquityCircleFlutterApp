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

import '../../../core/constants/theme_colors.dart';
import 'create_job_screen.dart';

void showPostOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: ThemeColors.background(context),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
    ),
    builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;

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
                child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: ThemeColors.search(context),
                  child: SvgPicture.asset(
                    Assets.close,
                    height: 12.h,
                    width: 12.w,
                    color: ThemeColors.iconColor(context),
                  ),
                ),
              ),
            ),
            6.heightBox,
            Text(
              "Select post type",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.inter,
                color: ThemeColors.textColor(context),
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
                  color: isDark ? AppColors.white : AppColors.skyBlue,
                  textColor: isDark ? AppColors.white : AppColors.blue,
                  iconColor: isDark ? AppColors.white : AppColors.blue,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePostScreen(),
                      ),
                    );
                  },
                  context: context,
                ),
                _buildOption(
                  imgUrl: Assets.videoIcon,
                  label: "Post a video",
                  color: isDark ? AppColors.white : AppColors.seeGreen,
                  textColor: isDark ? AppColors.white : AppColors.green,
                  iconColor: isDark ? AppColors.white : AppColors.green,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePostScreen(),
                      ),
                    );
                  },
                  context: context,
                ),
                _buildOption(
                  imgUrl: Assets.createJobIcon,
                  label: "Create job",
                  color: isDark ? AppColors.white : AppColors.lightorange,
                  textColor: isDark ? AppColors.white : AppColors.orange,
                  iconColor: isDark ? AppColors.white : AppColors.orange,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateJobScreen(),
                      ),
                    );
                  },
                  context: context,
                ),
                _buildOption(
                  imgUrl: Assets.createEvent,
                  label: "Create event",
                  color: isDark ? AppColors.white : AppColors.lightRed,
                  textColor: isDark ? AppColors.white : AppColors.darkRed,
                  iconColor: isDark ? AppColors.white : AppColors.darkRed,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateEventScreen(),
                      ),
                    );
                  },
                  context: context,
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
  required Color iconColor,
  required VoidCallback onTap,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? null : color,
        gradient:
            Theme.of(context).brightness == Brightness.dark
                ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1D1D1D), // Fully opaque
                    Color(0x33282828), // 20% opacity
                  ],
                )
                : null,
        borderRadius: BorderRadius.circular(6.r),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(imgUrl, color: iconColor),
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
