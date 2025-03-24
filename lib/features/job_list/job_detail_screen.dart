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
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.offWhite,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: Text(
          "Details",
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Divider(color: AppColors.lightGreyColor, height: 0.5.h),

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
                  color: AppColors.black,
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
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.lightGreyColor,
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
                          color: AppColors.black,
                        ),
                      ),
                      8.heightBox,
                      CustomTextField(
                        controller: firstNameController,
                        hint: "Enter your first name",
                      ),
                      16.heightBox,
                      Text(
                        "Last Name",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      8.heightBox,
                      CustomTextField(
                        controller: lastNameController,
                        hint: "Enter your Last name",
                      ),

                      16.heightBox,
                      Text(
                        "Email Address",
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
                        hint: "User@gmail.com",
                      ),
                      16.heightBox,
                      Text(
                        "Country",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      8.heightBox,
                      DropdownButtonFormField<String>(
                        style: TextStyle(
                          fontFamily: AppFonts.inter,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkGrey,
                        ),
                        icon: SizedBox.shrink(),
                        value:
                            eventTypes.contains(countryController.text)
                                ? countryController.text
                                : null,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.lightGreyColor,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.lightGreyColor,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          hintText: "Select Event Type",
                          hintStyle: TextStyle(
                            fontFamily: AppFonts.inter,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkGrey,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  Assets.arrowDown,
                                  height: 16.h,
                                  width: 16.w,
                                ),
                              ],
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            maxHeight: 43,
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            maxHeight: 35,
                          ),
                        ),
                        items:
                            eventTypes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontFamily: AppFonts.inter,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            countryController.text = newValue!;
                          });
                        },
                      ),

                      16.heightBox,
                      Text(
                        "Upload CV (PDF Only)",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      8.heightBox,

                      Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.lightGreyColor,
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
                                  color: AppColors.extralightgrey,
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
                                        color: AppColors.darkGrey,
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
                          color: AppColors.black,
                        ),
                      ),
                      8.heightBox,
                      CustomTextField(
                        controller: jobtitleController,
                        hint: "Enter your Job Title",
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
