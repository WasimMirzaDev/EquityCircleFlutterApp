import 'package:dotted_border/dotted_border.dart';
import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/widgets/custom_textfield.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  String selectedPrivacy = "Public";
  String selectedCategory = "Business";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();

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
          "Edit post",
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
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: AppColors.lightGreyColor, height: 0.5.h),

            10.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: CircleAvatar(backgroundImage: AssetImage(Assets.dp)),
                  ),
                  10.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      16.heightBox,
                      Text(
                        "Areesha Haider",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        "Admin",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            20.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
              child: _buildPrivacySelector(),
            ),
            16.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   ".",
                  //   style: TextStyle(
                  //     fontSize: 30.sp,
                  //     fontFamily: AppFonts.inter,
                  //     color: AppColors.darkGrey,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
                  Text(
                    "Anyone can see your post",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            16.heightBox,
            Divider(color: AppColors.lightGreyColor, height: 1.h),
            16.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Category*",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  16.heightBox,
                  _buildCategorySelector(),
                  16.heightBox,
                  Text(
                    "Title*",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: titleController,
                    hint: "Enter title*",
                  ),
                  16.heightBox,
                  Text(
                    "Description*",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: titleController,
                    hint: "Write here...",
                    maxLines: 5,
                  ),
                  16.heightBox,
                  Text(
                    "Select Background",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  _buildBackgroundSelector(),
                  16.heightBox,
                  Text(
                    "Attachments",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  _buildAttachments(),
                  35.heightBox,

                  CustomButton(text: "Update Post", onTap: () {}),
                  24.heightBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _privacyButton("Public", Assets.publicIcon),
          _privacyButton("Private", Assets.privateIcon),
          _privacyButton("Password", Assets.lock),
        ],
      ),
    );
  }

  Widget _privacyButton(String label, String icon) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedPrivacy = label);
      },

      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Container(
          width: 113.w,
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border:
                selectedPrivacy == label
                    ? null
                    : Border.all(color: AppColors.lightGreyColor),
            color:
                selectedPrivacy == label
                    ? AppColors.purpleColor
                    : AppColors.offWhite,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                color:
                    selectedPrivacy == label
                        ? AppColors.white
                        : AppColors.black,
              ),
              5.widthBox,
              Text(
                label,

                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w400,
                  color:
                      selectedPrivacy == label
                          ? AppColors.white
                          : AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            ["Business", "Fitness", "Crypto", "Mindset"].map((category) {
              return _categoryButton(category);
            }).toList(),
      ),
    );
  }

  Widget _categoryButton(String category) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedCategory = category);
      },

      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Container(
          width: 82.w,
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border:
                selectedCategory == category
                    ? null
                    : Border.all(color: AppColors.lightGreyColor),
            color:
                selectedCategory == category
                    ? AppColors.purpleColor
                    : AppColors.offWhite,
          ),

          child: Center(
            child: Text(
              category,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: AppFonts.inter,
                fontWeight: FontWeight.w400,
                color:
                    selectedCategory == category
                        ? AppColors.white
                        : AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(6, (index) {
        return Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.primaries[index],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAttachments() {
    return Row(
      children: [
        _attachmentBox(Assets.pauseiCON),
        SizedBox(width: 12),
        _attachmentBox(Assets.photoIcon),
      ],
    );
  }

  Widget _attachmentBox(String icon) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(8.r),
      strokeWidth: 0.5,
      dashPattern: [6, 4],
      color: AppColors.purpleColor,
      child: Container(
        width: 66.w,
        height: 66.h,
        decoration: BoxDecoration(
          color: AppColors.babyPink,
          // border: Border.all(color: AppColors.purpleColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            height: 18.h,
            width: 18.w,
            color: AppColors.purpleColor,
          ),
        ),
      ),
    );
  }
}
