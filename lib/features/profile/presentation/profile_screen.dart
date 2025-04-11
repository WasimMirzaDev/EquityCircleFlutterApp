import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/theme_colors.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../add_post/presentation/widget/discard_dialogbox.dart';
import '../../feeds/helpers/picture_helpers.dart';
import 'account_settings.dart';
import 'profile_settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
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
        backgroundColor: Colors.transparent,

        appBar: CustomAppBar(
          title: "Profile Settings",
          onLeadingPressed: () {
            Navigator.pop(context);
          },
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: ThemeColors.borderColor(context), height: 0.5.h),
              20.heightBox,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),

                decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeColors.borderColor(context),
                    width: 0.5,
                  ),
                  color: ThemeColors.background(context),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    16.heightBox,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ThemeColors.bottomNavColor(context),
                                width: 1.w,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: ThemeColors.borderColor(context),
                              radius: 24.r,
                              backgroundImage: NetworkImage(
                                getProfileImageUrl(authProvider.userData),
                              ),
                            ),
                          ),

                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Susan Sumanggih',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: AppFonts.inter,
                                    color: ThemeColors.subTextColor(context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                Text(
                                  'tienlapspktnd@gmail.com',
                                  style: TextStyle(
                                    fontFamily: AppFonts.inter,
                                    fontSize: 12.sp,
                                    color: ThemeColors.subTextColor(context),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 0.7, // Adjusts the size of the switch
                            child: Switch(
                              value:
                                  Provider.of<ThemeProvider>(
                                    context,
                                  ).isDarkMode,
                              onChanged: (value) {
                                Provider.of<ThemeProvider>(
                                  context,
                                  listen: false,
                                ).toggleTheme();
                              },
                              activeColor: ThemeColors.swtichDotColor(context),
                              activeTrackColor: ThemeColors.swtichBgColor(
                                context,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    16.heightBox,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          border: Border.all(
                            color: ThemeColors.borderColor(context),
                            width: 0.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'View Profile',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: AppFonts.inter,
                              color: ThemeColors.textColor(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    20.heightBox,
                    Divider(
                      color: ThemeColors.borderColor(context),
                      thickness: 0.5.h,
                    ),
                    8.heightBox,
                    _buildSettingItem(
                      Assets.profileSetting,
                      'Profile Setting',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileSettingsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildSettingItem(Assets.setting, 'Account Setting', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountSettingsScreen(),
                        ),
                      );
                    }),
                    _buildSettingItem(Assets.privacy, 'Privacy Setting', () {}),
                    _buildSettingItem(Assets.appsettings, 'App Setting', () {}),
                    _buildSettingItem(Assets.chat, 'Chat Setting', () {}),
                    8.heightBox,
                    Divider(
                      color: ThemeColors.borderColor(context),
                      thickness: 0.5.h,
                    ),
                    20.heightBox,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: GestureDetector(
                        onTap: () {
                          showDiscardDialog(
                            context,

                            "Log out",
                            "Are you sure you want to logout?",
                            "Cancel",
                            "Confirm",

                            () {
                              Navigator.pop(context, true);
                            },
                            () {
                              Provider.of<AuthProvider>(
                                context,
                                listen: false,
                              ).logout();
                              context.go('/login');
                            },
                          );
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(Assets.logoutIcon),
                            12.widthBox,
                            Text(
                              'Log out',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: AppFonts.inter,
                                color: AppColors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    16.heightBox,
                  ],
                ),
              ),
            ],
          ),
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
                SvgPicture.asset(icon, color: ThemeColors.iconColor(context)),

                12.widthBox,
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
