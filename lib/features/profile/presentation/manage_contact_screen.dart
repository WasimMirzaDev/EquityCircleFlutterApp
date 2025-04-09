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

class ManageContactScreen extends StatefulWidget {
  const ManageContactScreen({super.key});

  @override
  _ManageContactScreenState createState() => _ManageContactScreenState();
}

class _ManageContactScreenState extends State<ManageContactScreen> {
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
          "Manage Contact",
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
                    "Contact Number:",
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
                    hint: "Enter your contact number",
                    fillColor: ThemeColors.search(context),
                  ),
                  16.heightBox,
                  Text(
                    "Email:",
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
                    hint: "admin@gmail.com",
                    fillColor: ThemeColors.search(context),
                  ),
                  16.heightBox,
                  Text(
                    "Website URL:",
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
                    hint: "Enter your website URL",
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
