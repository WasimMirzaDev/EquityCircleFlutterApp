import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_button.dart' show CustomButton;
import 'package:equitycircle/core/widgets/custom_textfield.dart'
    show CustomTextField;
import 'package:equitycircle/features/job_list/widgets/job_list_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/theme_colors.dart';
import '../add_post/presentation/widget/custom_dropdown.dart';

class JobDetailScreen extends StatefulWidget {
  String image;
  String title;
  String discription;
  JobDetailScreen({
    super.key,
    required this.discription,
    required this.title,
    required this.image,
  });

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController jobtitleController = TextEditingController();

  final TextEditingController countryController = TextEditingController();
  String? fileName;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
    }
  }

  final List<String> eventTypes = ["Pakistan", "India", "USA", "Canada"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.background(context),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        backgroundColor: ThemeColors.background(context),
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: Text(
          "Details",
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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Divider(color: ThemeColors.borderColor(context), height: 0.5.h),

              20.heightBox,

              Row(
                children: [
                  SvgPicture.asset(Assets.equityIcon),
                  6.widthBox,
                  Text(
                    "Equity Circle",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.inter,
                      color: AppColors.purpleColor,
                    ),
                  ),
                ],
              ),
              5.heightBox,
              Text(
                "Complete the form below to have a copy of our resource sent direct your inbox.",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFonts.inter,
                  color: ThemeColors.textColor(context),
                ),
              ),
              20.heightBox,
              JobCardWidget(
                title: widget.title,
                image: widget.image,
                discription: widget.discription,
                readMore: false,
              ),
              20.heightBox,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: ThemeColors.cardColor(context),
                  border: Border.all(
                    color: ThemeColors.borderColor(context),
                    width: 0.28,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.heightBox,
                      Text(
                        "First Name",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.textColor(context),
                        ),
                      ),
                      8.heightBox,
                      CustomTextField(
                        controller: firstNameController,
                        hint: "Enter your first name",
                        fillColor: ThemeColors.search(context),
                      ),
                      16.heightBox,
                      Text(
                        "Last Name",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.textColor(context),
                        ),
                      ),
                      8.heightBox,
                      CustomTextField(
                        controller: lastNameController,
                        hint: "Enter your Last name",
                        fillColor: ThemeColors.search(context),
                      ),

                      16.heightBox,
                      Text(
                        "Email Address",
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
                        hint: "User@gmail.com",
                        fillColor: ThemeColors.search(context),
                      ),
                      16.heightBox,
                      Text(
                        "Country",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.textColor(context),
                        ),
                      ),
                      8.heightBox,

                      CustomDropdown(
                        controller: countryController,
                        selectedValue: countryController.text,
                        items: eventTypes,
                        onChanged: (newValue) {
                          setState(() {
                            countryController.text = newValue!;
                          });
                        },
                        hintText: "Select Country",
                      ),

                      16.heightBox,
                      Text(
                        "Upload CV (PDF Only)",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.textColor(context),
                        ),
                      ),
                      8.heightBox,

                      Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: ThemeColors.borderColor(context),
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: pickFile,
                              child: Container(
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: ThemeColors.search(context),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.r),
                                    bottomLeft: Radius.circular(8.r),
                                  ),
                                ),

                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                    ),
                                    child: Text(
                                      "Choose File",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: AppFonts.inter,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeColors.textColor(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            10.widthBox,
                            Text(
                              fileName ?? "No file chosen",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: AppFonts.inter,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: pickFile,
                      //   child: AbsorbPointer(
                      //     // Prevent manual text input
                      //     child: CustomTextField(
                      //       controller: titleController,
                      //       hint: "No file chosen",
                      //     ),
                      //   ),
                      // ),
                      16.heightBox,
                      Text(
                        "Job Title",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.textColor(context),
                        ),
                      ),
                      8.heightBox,
                      CustomTextField(
                        controller: jobtitleController,
                        hint: "Enter your Job Title",
                        fillColor: ThemeColors.search(context),
                      ),
                      25.heightBox,

                      CustomButton(
                        text: "Apply For Job",
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                      ),
                      24.heightBox,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
