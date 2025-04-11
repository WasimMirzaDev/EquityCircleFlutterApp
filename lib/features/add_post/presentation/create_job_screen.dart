import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/appColors.dart';
import '../../../core/constants/theme_colors.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_textfield.dart';

class CreateJobScreen extends StatefulWidget {
  const CreateJobScreen({super.key});

  @override
  _CreateJobScreenState createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
  final TextEditingController shortdiscriptionController =
      TextEditingController();

  final quill.QuillController _controller = quill.QuillController.basic();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
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
          title: "Create new job",
          onLeadingPressed: () {
            Navigator.pop(context);
          },
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: ThemeColors.borderColor(context), height: 0.5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    20.heightBox,
                    Text(
                      "Main image*",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.textColor(context),
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
                        color: ThemeColors.dottedColor(context),
                        child: Container(
                          width: double.infinity,
                          height: 150.h,
                          decoration: BoxDecoration(
                            color: ThemeColors.search(context),
                            // border: Border.all(color: AppColors.purpleColor),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child:
                              _selectedImage == null
                                  ? Center(
                                    child: SvgPicture.asset(
                                      Assets.photoIcon,
                                      height: 18.h,
                                      width: 18.w,
                                      color: ThemeColors.dottedColor(context),
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
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: titleController,
                      hint: "Enter title*",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,
                    Text(
                      "Short Description*",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: shortdiscriptionController,
                      hint: "Enter Short Description*",
                      fillColor: ThemeColors.search(context),
                      maxLines: 5,
                    ),
                    16.heightBox,
                    Text(
                      "Description*",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: discriptionController,
                      hint: "Enter Description*",
                      fillColor: ThemeColors.search(context),
                      maxLines: 4,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: AppColors.white,
                    //     border: Border.all(
                    //       color: AppColors.lightGreyColor,
                    //       width: 0.5,
                    //     ),
                    //     borderRadius: BorderRadius.circular(8.r),
                    //   ),
                    //   child: CustomQuillEditor(
                    //     controller: _controller,
                    //     backgroundColor: AppColors.white,
                    //   ),
                    // ),
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
