import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/appColors.dart';
import '../../../core/constants/theme_colors.dart';
import '../../../core/models/feeds_model.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../bussiness/presentation/widgets/custom_post_container.dart';

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

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              image: AssetImage(
                                Assets.carousalImg,
                              ), // Replace with your cover image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        16.heightBox,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      SizedBox(width: 12),
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
                          tabs: [
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
                20.heightBox,
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
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20.r,
                                backgroundImage: AssetImage(Assets.dp),
                              ),
                              10.widthBox,
                              Expanded(
                                child: CustomTextField(
                                  controller: postController,
                                  hint: "Start a post",
                                  fillColor: ThemeColors.search(context),
                                ),
                              ),
                            ],
                          ),
                          10.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _PostIcon(
                                label: 'Photos',
                                icon: Assets.pictureIcon,
                              ),
                              5.widthBox,
                              _PostIcon(
                                label: 'Videos',
                                icon: Assets.videoPostIcon,
                              ),
                              5.widthBox,
                              _PostIcon(label: 'Jobs', icon: Assets.jobIcon),
                              5.widthBox,
                              _PostIcon(
                                label: 'Events',
                                icon: Assets.eventPostIcon,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                10.heightBox,
                ...List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: customPostContainer(
                      DataByFeed(), // dummy post model
                      0, // feedId
                      1, // categoryId
                      'https://images.unsplash.com/photo-1575936123452-b67c3203c357?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D', // profileUrl
                      'John Doe', // name
                      'April 16, 2025', // date
                      'This is a dummy post description for testing purpose.', // description
                      () => print("Comment tapped"), // commentTap
                      () => print("Like tapped"), // favTap
                      'Business', // tab label
                      Colors.blue.shade100, // tabBgColor
                      Colors.blue, // tabTextColor
                      [
                        MediaByFeeds(
                          url:
                              'https://images.unsplash.com/photo-1575936123452-b67c3203c357?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
                        ), // dummy media
                      ],
                      context,
                      List.generate(3, (i) => 'Like $i'), // likes
                      index % 2 == 0, // isLiked
                      List.generate(2, (i) => 'Comment $i'), // comments
                      true, // isAdmin
                    ),
                  );
                }),
                10.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostIcon extends StatelessWidget {
  final String label;
  final String icon;

  const _PostIcon({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        8.widthBox,
        Text(
          label,
          style: TextStyle(
            color: ThemeColors.subTextColor(context),
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.inter,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
