import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/theme_colors.dart' show ThemeColors;
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/appColors.dart';
import '../../../core/constants/assets.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/widgets/custom_appbar.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  // Toggle switches
  bool isPrivate = true;
  bool isActive = true;
  bool isStorySharing = true;
  bool isLoginNotificationEnabled = true;

  // Radio button selections
  String photoOption = 'auto';
  String profileVisibility = 'public';

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
        backgroundColor: AppColors.transparent,

        appBar: CustomAppBar(
          title: "Privacy Settings",
          onLeadingPressed: () {
            Navigator.pop(context);
          },
        ),

        body: ListView(
          children: [
            Divider(color: ThemeColors.borderColor(context), thickness: 0.5.h),
            16.heightBox,
            _buildSwitchTile(
              title: 'Private Account',
              value: isPrivate,
              onChanged: (val) => setState(() => isPrivate = val),
            ),
            16.heightBox,
            Divider(color: ThemeColors.borderColor(context), thickness: 0.5.h),
            _buildSwitchTile(
              title: 'Active Status',
              value: isActive,
              onChanged: (val) => setState(() => isActive = val),
            ),
            16.heightBox,
            Divider(color: ThemeColors.borderColor(context), thickness: 0.5.h),
            _buildSwitchTile(
              title: 'Story Sharing',
              value: isStorySharing,
              onChanged: (val) => setState(() => isStorySharing = val),
            ),
            16.heightBox,
            Divider(color: ThemeColors.borderColor(context), thickness: 0.5.h),
            16.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Photo Of You',
                style: TextStyle(
                  color: ThemeColors.textColor(context),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.inter,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  _buildRadioTile('Add Automatically', 'auto', photoOption, (
                    val,
                  ) {
                    setState(() => photoOption = val!);
                  }),
                  _buildRadioTile('Add Manually', 'manual', photoOption, (val) {
                    setState(() => photoOption = val!);
                  }),
                ],
              ),
            ),
            _buildDescription(),
            16.heightBox,
            Divider(color: ThemeColors.borderColor(context), thickness: 0.5.h),
            16.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Your Profile',
                style: TextStyle(
                  color: ThemeColors.textColor(context),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.inter,
                  fontSize: 12.sp,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildRadioTile('Public', 'public', profileVisibility, (
                      val,
                    ) {
                      setState(() => profileVisibility = val!);
                    }),
                    _buildRadioTile('Friend', 'friend', profileVisibility, (
                      val,
                    ) {
                      setState(() => profileVisibility = val!);
                    }),
                    _buildRadioTile(
                      'Specific Friend',
                      'specific',
                      profileVisibility,
                      (val) {
                        setState(() => profileVisibility = val!);
                      },
                    ),
                    _buildRadioTile('Only Me', 'only_me', profileVisibility, (
                      val,
                    ) {
                      setState(() => profileVisibility = val!);
                    }),
                  ],
                ),
              ),
            ),

            _buildDescription(),
            16.heightBox,
            Divider(color: ThemeColors.borderColor(context), thickness: 0.5.h),
            16.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Login Notification',
                style: TextStyle(
                  color: ThemeColors.textColor(context),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.inter,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  _buildRadioTile(
                    'Enable',
                    'enable',
                    isLoginNotificationEnabled ? 'enable' : 'disable',
                    (val) {
                      setState(
                        () => isLoginNotificationEnabled = val == 'enable',
                      );
                    },
                  ),
                  _buildRadioTile(
                    'Disable',
                    'disable',
                    isLoginNotificationEnabled ? 'enable' : 'disable',
                    (val) {
                      setState(
                        () => isLoginNotificationEnabled = val == 'enable',
                      );
                    },
                  ),
                ],
              ),
            ),

            _buildDescription(),
            16.heightBox,
            Divider(color: ThemeColors.borderColor(context), thickness: 0.5.h),

            16.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Privacy Help',
                style: TextStyle(
                  color: ThemeColors.textColor(context),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.inter,
                  fontSize: 12.sp,
                ),
              ),
            ),
            16.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                height: 38.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: ThemeColors.borderColor(context)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.supportIcon,
                        color: ThemeColors.radiobtn(context),
                      ),
                      8.widthBox,
                      Text(
                        'Support',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.textColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            16.heightBox,
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ThemeColors.textColor(context),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.inter,
                  fontSize: 12.sp,
                ),
              ),
              Transform.scale(
                scale: 0.6,
                child: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: ThemeColors.swtichDotColor(context),
                  activeTrackColor: ThemeColors.swtichBgColor(context),
                ),
              ),
            ],
          ),
        ),

        _buildDescription(),
      ],
    );
  }

  Widget _buildRadioTile(
    String title,
    String value,
    String groupValue,
    ValueChanged<String?> onChanged,
  ) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },

      child: Row(
        children: [
          Radio<String>(
            value: value,
            activeColor: ThemeColors.radiobtn(context),
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          Text(
            title,
            style: TextStyle(
              color: ThemeColors.textColor(context),
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.inter,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
        'when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
        style: TextStyle(
          fontSize: 10.sp,
          fontFamily: AppFonts.inter,
          fontWeight: FontWeight.w400,
          color: ThemeColors.subTextColor(context),
        ),
      ),
    );
  }
}
