import 'package:equitycircle/core/constants/theme_colors.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/appFonts.dart';
import '../../../core/constants/assets.dart';
import '../presentation/contact_and_basic_info_screen.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({super.key});

  @override
  _AboutTabState createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  8.heightBox,
                  _buildSettingItem(
                    Assets.profileSetting,
                    'Contact and basic info',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactAndBasicInfoScreen(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: ThemeColors.borderColor(context),
                    thickness: 0.5.h,
                  ),
                  _buildSettingItem(
                    Assets.setting,
                    'Hobbies and interests',
                    () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ChangePasswordScreen(),
                      //   ),
                      // );
                    },
                  ),
                  Divider(
                    color: ThemeColors.borderColor(context),
                    thickness: 0.5.h,
                  ),
                  _buildSettingItem(Assets.privacy, 'Work and Education', () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EmailAndSmsScreen(),
                    //   ),
                    // );
                  }),
                  Divider(
                    color: ThemeColors.borderColor(context),
                    thickness: 0.5.h,
                  ),
                  _buildSettingItem(
                    Assets.appsettings,
                    'Places You’ve Lived',
                    () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ManageContactScreen(),
                      //   ),
                      // );
                    },
                  ),

                  8.heightBox,
                ],
              ),
            ),
          ),
        ],
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
                    color: ThemeColors.textColor(context),
                    fontFamily: AppFonts.inter,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              Assets.arrowRight,
              color: ThemeColors.commentfielIconsColor(context),
            ),
          ],
        ),
      ),
    );
  }
}
