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

class CreatNewJobScreen extends StatefulWidget {
  const CreatNewJobScreen({super.key});

  @override
  _CreatNewJobScreenState createState() => _CreatNewJobScreenState();
}

class _CreatNewJobScreenState extends State<CreatNewJobScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
  final TextEditingController shortdiscriptionController =
      TextEditingController();

  final quill.QuillController _controller = quill.QuillController.basic();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
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
          "Create new job",
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  20.heightBox,
                  Text(
                    "Main image",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  GestureDetector(
                    onTap: _pickImage,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(8.r),
                      strokeWidth: 0.5,
                      dashPattern: [6, 4],
                      color: AppColors.lightGreyColor,
                      child: Container(
                        width: double.infinity,
                        height: 150.h,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          // border: Border.all(color: AppColors.purpleColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child:
                            _selectedImage == null
                                ? Center(
                                  child: SvgPicture.asset(
                                    Assets.jobImgIcon,
                                    height: 24.h,
                                    width: 24.w,
                                  ),
                                )
                                : ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.file(
                                    File(_selectedImage!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                      ),
                    ),
                  ),
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
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SvgPicture.asset(Assets.smileIcon),
                    ),
                  ),
                  16.heightBox,
                  Text(
                    "Short Description*",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: shortdiscriptionController,
                    hint: "Enter Short Description*",
                    maxLines: 5,
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
                    child: Column(
                      children: [
                        CustomQuillEditor(
                          controller: _controller,
                          backgroundColor: AppColors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12.w, bottom: 12.h),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset(Assets.smileIcon),
                          ),
                        ),
                      ],
                    ),
                  ),
                  30.heightBox,

                  CustomButton(
                    text: "Create job",
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

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }
}
