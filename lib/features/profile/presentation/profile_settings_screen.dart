import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/features/profile/presentation/change_password_screen.dart';
import 'package:equitycircle/features/profile/presentation/manage_contact_screen.dart';
import 'package:equitycircle/features/profile/presentation/personal_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'email_and_sms_screen.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
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
          "Profile Setting",
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: AppColors.lightGreyColor, thickness: 0.5.h),
            20.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.lightGreyColor,
                    width: 0.5,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    8.heightBox,
                    _buildSettingItem(
                      Assets.profileSetting,
                      'Personal Info',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalInfoScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(color: AppColors.lightGreyColor, thickness: 0.5.h),
                    _buildSettingItem(Assets.setting, 'Change Password', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen(),
                        ),
                      );
                    }),
                    Divider(color: AppColors.lightGreyColor, thickness: 0.5.h),
                    _buildSettingItem(Assets.privacy, 'Email and SMS', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailAndSmsScreen(),
                        ),
                      );
                    }),
                    Divider(color: AppColors.lightGreyColor, thickness: 0.5.h),
                    _buildSettingItem(Assets.appsettings, 'Manage Contact', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManageContactScreen(),
                        ),
                      );
                    }),

                    8.heightBox,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(String icon, String title, VoidCallback ontap) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.h),
      child: GestureDetector(
        onTap: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.black,
                    fontFamily: AppFonts.inter,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(Assets.arrowRight),
          ],
        ),
      ),
    );
  }
}
