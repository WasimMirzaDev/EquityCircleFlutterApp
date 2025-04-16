import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_appbar.dart' show CustomAppBar;
import 'package:equitycircle/features/profile/presentation/personal_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/appColors.dart';
import '../../../core/constants/theme_colors.dart';
import 'change_password_screen.dart';
import 'email_and_sms_screen.dart';
import 'manage_contact_screen.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
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
              Divider(
                color: ThemeColors.borderColor(context),
                thickness: 0.5.h,
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
                      Divider(
                        color: ThemeColors.borderColor(context),
                        thickness: 0.5.h,
                      ),
                      _buildSettingItem(Assets.setting, 'Change Password', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(),
                          ),
                        );
                      }),
                      Divider(
                        color: ThemeColors.borderColor(context),
                        thickness: 0.5.h,
                      ),
                      _buildSettingItem(Assets.privacy, 'Email and SMS', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmailAndSmsScreen(),
                          ),
                        );
                      }),
                      Divider(
                        color: ThemeColors.borderColor(context),
                        thickness: 0.5.h,
                      ),
                      _buildSettingItem(
                        Assets.appsettings,
                        'Manage Contact',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ManageContactScreen(),
                            ),
                          );
                        },
                      ),

                      8.heightBox,
                    ],
                  ),
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
