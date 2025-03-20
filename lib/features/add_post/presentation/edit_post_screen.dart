import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_button.dart';
import 'package:equitycircle/features/add_post/presentation/widget/custom_quill_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/widgets/custom_textfield.dart';
import 'widget/discard_dialogbox.dart';

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
  final quill.QuillController _controller = quill.QuillController.basic();
  List<String> attachments = []; // Store attachment paths

  Future<void> _pickAttachment() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        attachments.add(pickedFile.path);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  Color _selectedBackground = Colors.white;
  final List<Color> _backgrounds = [
    Colors.white,
    Color(0xFFFFF0D6),
    Color(0xFFE0C3FC),
    Color(0xFFB2EBF2),
    Color(0xFFF8BBD0),
    Color(0xFFC8E6C9),
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
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(Assets.close, height: 12.h),
            onPressed: () {
              showDiscardDialog(
                context,

                "Discard Changes?",
                "Are you sure you want to discard your changes? All unsaved modifications will be lost.",
                "Cancel",
                "Discard",

                () {
                  Navigator.pop(context, true);
                },
                () {
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                },
              );
            },
          ),
        ],
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
                    "• ",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGrey,
                    ),
                  ),
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
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.lightGreyColor,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CustomQuillEditor(
                      controller: _controller,
                      backgroundColor: _selectedBackground,
                    ),
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
                  // _buildBackgroundSelector(),
                  Wrap(
                    spacing: 10,
                    children:
                        _backgrounds.map((color) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedBackground = color;
                              });
                            },
                            child: Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: AppColors.lightGreyColor,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
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

                  CustomButton(
                    text: "Edit Post",
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  24.heightBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachments() {
    return Wrap(
      spacing: 10,

      children: [
        _attachmentBox(Assets.pauseiCON, "video"),
        // _attachmentBox(Assets.photoIcon, "photo"),
        ...attachments.map((path) => _attachmentPreview(path)),
        _addAttachmentBox(),
      ],
    );
  }

  Widget _attachmentBox(String icon, String type) {
    return GestureDetector(
      onTap: () {
        if (type == "video") {
        } else if (type == "photo") {
          _pickAttachment();
        }
      },
      child: DottedBorder(
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
      ),
    );
  }

  Widget _attachmentPreview(String path) {
    return Stack(
      children: [
        Container(
          width: 66.w,
          height: 66.h,
          decoration: BoxDecoration(
            color: AppColors.babyPink,
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(
              image: FileImage(File(path)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: GestureDetector(
            onTap: () => _removeAttachment(attachments.indexOf(path)),
            child: Icon(Icons.cancel, size: 16, color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _addAttachmentBox() {
    return GestureDetector(
      onTap: _pickAttachment,
      child: DottedBorder(
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
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              Assets.photoIcon,
              height: 18.h,
              width: 18.w,
              color: AppColors.purpleColor,
            ),
          ),
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
}
