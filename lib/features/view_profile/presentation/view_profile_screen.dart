import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/appColors.dart';
import '../../../core/constants/theme_colors.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../widgets/about_tab.dart';
import '../widgets/timeline_tab.dart';

class ViewProfileScreen extends StatelessWidget {
  ViewProfileScreen({super.key});

  final TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 5,
      child: Container(
        decoration:
            isDarkMode
                ? BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.postFormBg),
                    fit: BoxFit.fill,
                  ),
                )
                : BoxDecoration(color: AppColors.white),
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: CustomAppBar(
            title: 'View Profile',
            onLeadingPressed: () {
              Navigator.pop(context);
            },
          ),
          body: Column(
            children: [
              Divider(
                color: ThemeColors.borderColor(context),
                thickness: 0.5.h,
              ),
              16.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ThemeColors.borderColor(context),
                      width: 0.5,
                    ),
                    color: ThemeColors.cardColor(context),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6.r),
                            topRight: Radius.circular(6.r),
                          ),
                          image: DecorationImage(
                            image: AssetImage(Assets.carousalImg),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      16.heightBox,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20.r,
                              backgroundImage: AssetImage(Assets.dp),
                            ),
                            10.widthBox,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Admin',
                                  style: TextStyle(
                                    color: ThemeColors.textColor(context),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFonts.inter,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  'admin@123gmail.com',
                                  style: TextStyle(
                                    color: ThemeColors.subTextColor(context),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: AppFonts.inter,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                10.heightBox,
                                Row(
                                  children: [
                                    Text(
                                      '14 ',
                                      style: TextStyle(
                                        color: ThemeColors.textColor(context),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppFonts.inter,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    Text(
                                      'Post',
                                      style: TextStyle(
                                        color: ThemeColors.subTextColor(
                                          context,
                                        ),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppFonts.inter,
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                    10.widthBox,
                                    Text(
                                      '2 ',
                                      style: TextStyle(
                                        color: ThemeColors.textColor(context),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppFonts.inter,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    Text(
                                      'Comments',
                                      style: TextStyle(
                                        color: ThemeColors.subTextColor(
                                          context,
                                        ),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppFonts.inter,
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                    12.widthBox,
                                    Text(
                                      '6 ',
                                      style: TextStyle(
                                        color: ThemeColors.textColor(context),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppFonts.inter,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    Text(
                                      'Like',
                                      style: TextStyle(
                                        color: ThemeColors.subTextColor(
                                          context,
                                        ),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppFonts.inter,
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      12.heightBox,
                      TabBar(
                        tabAlignment: TabAlignment.start,
                        padding: EdgeInsets.zero,
                        isScrollable: true,
                        unselectedLabelStyle: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.textColor(context),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.textColor(context),
                        ),
                        indicatorColor: ThemeColors.textColor(context),
                        labelColor: ThemeColors.textColor(context),
                        unselectedLabelColor: ThemeColors.textColor(context),
                        tabs: const [
                          Tab(text: 'Timeline'),
                          Tab(text: 'About'),
                          Tab(text: 'Friends'),
                          Tab(text: 'Photos'),
                          Tab(text: 'Life Events'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    TimeLineTab(postController: postController),
                    AboutTab(),

                    Center(child: Text("No data found")),
                    Center(child: Text("No data found")),
                    Center(child: Text("No data found")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
