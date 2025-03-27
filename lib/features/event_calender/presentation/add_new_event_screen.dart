import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/widgets/custom_textfield.dart';

class AddNewEventScreen extends StatefulWidget {
  const AddNewEventScreen({super.key});

  @override
  _AddNewEventScreenState createState() => _AddNewEventScreenState();
}

class _AddNewEventScreenState extends State<AddNewEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
  final TextEditingController shortdiscriptionController =
      TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController eventTypeController = TextEditingController();
  final TextEditingController eventVisibilityController =
      TextEditingController();

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        eventDateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context); // Formats the time
      });
    }
  }

  final List<String> eventTypes = [
    "Conference",
    "Workshop",
    "Meetup",
    "Webinar",
  ];
  final List<String> eventVisibility = ["Private", "Public", "Password"];
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
          "Add New Event",
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            });
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
                    hint: "Enter title",
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SvgPicture.asset(Assets.smileIcon),
                    ),
                  ),
                  16.heightBox,
                  Text(
                    "Subtitle",
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
                    hint: "Enter subtitle",
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SvgPicture.asset(Assets.smileIcon),
                    ),
                  ),
                  16.heightBox,
                  Text(
                    "Short Description",
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
                    hint: "Write here...",
                    maxLines: 3,
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
                    controller: discriptionController,
                    hint: "Write here...",
                    maxLines: 4,
                  ),
                  16.heightBox,
                  Text(
                    "Event date*",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: eventDateController,
                    hint: "dd/mm/yyyy",
                    onTap: () => _selectDate(context),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SvgPicture.asset(Assets.calendar),
                    ),
                  ),
                  16.heightBox,
                  Text(
                    "Start & End time*",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child: CustomTextField(
                            controller: startDateController,
                            hint: "Set start time",
                            onTap:
                                () => _selectTime(context, startDateController),
                            maxLines: 5,
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: SvgPicture.asset(Assets.clock),
                            ),
                          ),
                        ),
                      ),
                      10.widthBox,
                      Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child: CustomTextField(
                            controller: endDateController,
                            onTap:
                                () => _selectTime(context, endDateController),
                            hint: "Set end time",
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: SvgPicture.asset(Assets.clock),
                            ),
                            maxLines: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  16.heightBox,

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Type",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: AppFonts.inter,
                                fontWeight: FontWeight.w400,
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
                                  eventTypes.contains(eventTypeController.text)
                                      ? eventTypeController.text
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
                                hintText: "Select type",
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
                                  eventTypeController.text = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      10.widthBox,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Visibility",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: AppFonts.inter,
                                fontWeight: FontWeight.w400,
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
                                  eventTypes.contains(
                                        eventVisibilityController.text,
                                      )
                                      ? eventVisibilityController.text
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
                                hintText: "Public",
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
                                  eventVisibility.map((String value) {
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
                                  eventVisibilityController.text = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  30.heightBox,

                  CustomButton(
                    text: "Create Event",
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
