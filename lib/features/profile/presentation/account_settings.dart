import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/features/profile/widgets/custom_two_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/widgets/custom_textfield.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController alternateEmailController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController googleController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  List<String> selectedLanguages = ['English', 'French', 'Spanish', 'Hindi'];
  final List<String> allLanguages = [
    'English',
    'French',
    'Spanish',
    'Hindi',
    'Arabic',
    'Italian',
  ];
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
          "Account Setting",
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
            Divider(color: AppColors.lightGreyColor, height: 0.5.h),
            20.heightBox,

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  16.heightBox,
                  Text(
                    "User Name:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: usernameController,
                    hint: "Bni@01",
                  ),
                  16.heightBox,
                  Text(
                    "Email Id:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: emailController,
                    hint: "Bnijohn@gmail.com",
                  ),
                  16.heightBox,
                  Text(
                    "Alternate Email:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: alternateEmailController,
                    hint: "designtheme@gmail.com",
                  ),
                  16.heightBox,
                  Text(
                    "Language Known:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  16.heightBox,
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children:
                        allLanguages.map((lang) {
                          final isSelected = selectedLanguages.contains(lang);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedLanguages.remove(lang);
                                } else {
                                  selectedLanguages.add(lang);
                                }
                              });
                            },
                            child: Container(
                              height: 26.h,
                              width: 83.w,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color:
                                    isSelected
                                        ? AppColors.purpleColor
                                        : AppColors.babyPink,
                              ),
                              child: Center(
                                child: Text(
                                  lang,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: AppFonts.inter,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isSelected
                                            ? AppColors.white
                                            : AppColors.babyPink,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),

                  30.heightBox,
                  Text(
                    "Social Media",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  16.heightBox,
                  Text(
                    "Facebook:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: facebookController,
                    hint: "www.facebook.com",
                  ),
                  16.heightBox,

                  Text(
                    "Twitter:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: twitterController,
                    hint: "www.twitter.com",
                  ),

                  16.heightBox,
                  Text(
                    "Google +:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: googleController,
                    hint: "www.google.com",
                  ),
                  16.heightBox,

                  Text(
                    "Instagram:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: instagramController,
                    hint: "www.instagram.com",
                  ),
                  16.heightBox,

                  Text(
                    "You Tube:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: youtubeController,
                    hint: "www.youtube.com",
                  ),
                  16.heightBox,
                  CustomTwoButtonsRow(
                    cancelText: "Cancel",
                    confirmText: "Save change",
                  ),
                ],
              ),
            ),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
