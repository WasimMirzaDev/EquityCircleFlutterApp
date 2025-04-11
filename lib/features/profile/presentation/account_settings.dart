import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_appbar.dart' show CustomAppBar;
import 'package:equitycircle/features/profile/widgets/custom_two_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/theme_colors.dart';
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
          title: "Account Setting",
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
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: usernameController,
                      hint: "Bni@01",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,
                    Text(
                      "Email Id:",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: emailController,
                      fillColor: ThemeColors.search(context),
                      hint: "Bnijohn@gmail.com",
                    ),
                    16.heightBox,
                    Text(
                      "Alternate Email:",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: alternateEmailController,
                      hint: "designtheme@gmail.com",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,
                    Text(
                      "Language Known:",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.textColor(context),
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

                                  gradient:
                                      Theme.of(context).brightness ==
                                                  Brightness.dark &&
                                              isSelected
                                          ? const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0x80FFFFFF), // 50% opacity
                                              Color(0x1AFFFFFF),
                                            ],
                                          )
                                          : null,

                                  color:
                                      isSelected
                                          ? Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? null
                                              : AppColors.purpleColor
                                          : ThemeColors.postCatagoriesBox(
                                            context,
                                          ),
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
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    16.heightBox,
                    Text(
                      "Facebook:",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: facebookController,
                      hint: "www.facebook.com",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,

                    Text(
                      "Twitter:",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: twitterController,
                      hint: "www.twitter.com",
                      fillColor: ThemeColors.search(context),
                    ),

                    16.heightBox,
                    Text(
                      "Google +:",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: googleController,
                      hint: "www.google.com",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,

                    Text(
                      "Instagram:",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: instagramController,
                      hint: "www.instagram.com",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,

                    Text(
                      "You Tube:",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: youtubeController,
                      hint: "www.youtube.com",
                      fillColor: ThemeColors.search(context),
                    ),
                    20.heightBox,
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
      ),
    );
  }
}
