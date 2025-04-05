import 'dart:io';

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
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_textfield.dart';
import '../../core/constants/theme_colors.dart';
import '../../core/providers/education_provider.dart';
import '../../core/widgets/custom_snackbar.dart';

class AddEducationScreen extends StatefulWidget {
  const AddEducationScreen({super.key});

  @override
  _AddEducationScreenState createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortdiscriptionController =
      TextEditingController();
  final TextEditingController videoUrlController = TextEditingController();

  final TextEditingController discriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  bool _isLoading = false;
  // Function to validate URL
  bool _isValidUrl(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null &&
        uri.hasScheme &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.background(context),
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: ThemeColors.background(context),
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: Text(
          "Add New Education Content",
          style: TextStyle(
            color: ThemeColors.textColor(context),
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.inter,
            fontSize: 14.sp,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.backArrow,
            height: 20.h,
            color: ThemeColors.iconColor(context),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: ThemeColors.borderColor(context), height: 0.5.h),

              20.heightBox,
              Text(
                "Main image",
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
                  color: AppColors.lightGreyColor,
                  child: Container(
                    width: double.infinity,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: ThemeColors.search(context),
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
                  color: ThemeColors.textColor(context),
                ),
              ),
              8.heightBox,
              CustomTextField(
                controller: titleController,
                hint: "Enter title*",
                fillColor: ThemeColors.search(context),
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
              16.heightBox,
              Text(
                "Video URL*",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w400,
                  color: ThemeColors.textColor(context),
                ),
              ),
              8.heightBox,
              CustomTextField(
                controller: videoUrlController,
                hint: "Enter Video URL",
                fillColor: ThemeColors.search(context),
              ),
              20.heightBox,

              CustomButton(
                loading: _isLoading,
                text: _isLoading ? "Saving..." : "Save Content",
                onTap: () async {
                  if (titleController.text.isEmpty ||
                      shortdiscriptionController.text.isEmpty ||
                      discriptionController.text.isEmpty ||
                      _selectedImage == null ||
                      videoUrlController.text.isEmpty) {
                    showTopSnackbar(
                      context,
                      "Please fill all required fields",
                      false,
                    );

                    return;
                  }

                  // Video URL validation
                  if (!_isValidUrl(videoUrlController.text)) {
                    showTopSnackbar(
                      context,
                      "Please enter a valid video URL",
                      false,
                    );

                    return;
                  }

                  setState(() {
                    _isLoading =
                        true; // Set loading to true before starting the save process
                  });

                  String imagePath = _selectedImage!.path;

                  final provider = Provider.of<EducationProvider>(
                    context,
                    listen: false,
                  );

                  try {
                    await provider.createEducation(
                      context,
                      titleController.text,
                      shortdiscriptionController.text,
                      discriptionController.text,
                      imagePath,
                      videoUrlController.text, // Pass the video URL
                    );
                    showTopSnackbar(
                      context,
                      "Education content created successfully!",
                      true,
                    );

                    Navigator.pop(context, true);
                  } catch (e) {
                    showTopSnackbar(
                      context,
                      "Failed to create education content",
                      false,
                    );
                    print("Failed to create education content$e");
                  } finally {
                    setState(() {
                      _isLoading =
                          false; // Set loading to false after the save operation is done
                    });
                  }
                },
              ),
              24.heightBox,
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
