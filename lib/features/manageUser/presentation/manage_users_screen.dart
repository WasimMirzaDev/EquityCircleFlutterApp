import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/assets.dart';
import '../../bussiness/presentation/widgets/custom_search_field.dart';

class User {
  final String name;
  final String email;
  final String avatarUrl;

  User({required this.name, required this.email, required this.avatarUrl});
}

class ManageUserScreen extends StatelessWidget {
  final List<User> users = [
    User(
      name: "Jenny Wilson",
      email: "georgia.young@example.com",
      avatarUrl: "https://randomuser.me/api/portraits/women/44.jpg",
    ),
    User(
      name: "Robert Fox",
      email: "debra.holt@example.com",
      avatarUrl: "https://randomuser.me/api/portraits/men/46.jpg",
    ),
    User(
      name: "Ronald Richards",
      email: "nathan.roberts@example.com",
      avatarUrl: "https://randomuser.me/api/portraits/men/33.jpg",
    ),
    User(
      name: "Theresa Webb",
      email: "sara.cruz@example.com",
      avatarUrl: "https://randomuser.me/api/portraits/women/68.jpg",
    ),
  ];

  ManageUserScreen({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: AppColors.offWhite,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: Text(
          "Mange Users",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.inter,
            fontSize: 14.sp,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(Assets.backArrow, height: 20.h),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Divider(color: AppColors.lightGreyColor, height: 0.5.h),
          20.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: customSearchWidget(
              "   Search for users",
              searchController,
              context,
            ),
          ),
          20.heightBox,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.lightGreyColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            // Avatar
                            CircleAvatar(
                              radius: 24.r,
                              backgroundImage: NetworkImage(
                                users[index].avatarUrl,
                              ),
                            ),
                            12.widthBox,
                            // Name & Email
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    users[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      color: AppColors.black,
                                      fontFamily: AppFonts.inter,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    users[index].email,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      color: AppColors.black,
                                      fontFamily: AppFonts.inter,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Button
                            Container(
                              height: 24.h,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),

                                color: AppColors.purpleColor,
                              ),

                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Center(
                                  child: Text(
                                    "Permissions",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontFamily: AppFonts.inter,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
