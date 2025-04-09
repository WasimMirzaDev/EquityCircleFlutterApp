import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/theme_colors.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../widgets/custom_two_buttons.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController titleController = TextEditingController();

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
          "Change Password",
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: AppColors.lightGreyColor, thickness: 0.5.h),
          20.heightBox,

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current password",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.textColor(context),
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: titleController,
                    hint: "Enter your current password",
                    fillColor: ThemeColors.search(context),
                  ),
                  16.heightBox,
                  Text(
                    "New password",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.textColor(context),
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: titleController,
                    hint: "Enter new password ( min 8 characters)",
                    fillColor: ThemeColors.search(context),
                  ),
                  16.heightBox,
                  Text(
                    "Verify password",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.textColor(context),
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: titleController,
                    hint: "Confirm new password",
                    fillColor: ThemeColors.search(context),
                  ),
                  16.heightBox,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomTwoButtonsRow(
              cancelText: "Cancel",
              confirmText: "Save change",
            ),
          ),
          50.heightBox,
        ],
      ),
    );
  }
}
