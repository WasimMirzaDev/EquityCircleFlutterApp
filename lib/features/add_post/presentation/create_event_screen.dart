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

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final TextEditingController eventTypeController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  bool isActive = true;
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

  final List<String> eventTypes = [
    "Conference",
    "Workshop",
    "Meetup",
    "Webinar",
  ];
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
          "Create new event",
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  20.heightBox,
                  Text(
                    "Event type*",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  DropdownButtonFormField<String>(
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
                      hintText: "Select Event Type",
                      hintStyle: TextStyle(
                        fontFamily: AppFonts.inter,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey,
                      ),
                      suffixIcon: Row(
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
                    items:
                        eventTypes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        eventTypeController.text = newValue!;
                      });
                    },
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
                  ),
                  16.heightBox,
                  Text(
                    "Subtitle*",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: subtitleController,
                    hint: "Enter subtitle",
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
                    maxLines: 5,
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
                      padding: EdgeInsets.only(right: 10.w),
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
                            hint: "Start time",
                            maxLines: 5,
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 10.w),
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
                            hint: "End time",
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: SvgPicture.asset(Assets.clock),
                            ),
                            maxLines: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  4.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Event active",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      Transform.scale(
                        scale: 0.7, // Adjusts the size of the switch
                        child: Switch(
                          value: isActive,
                          onChanged: (value) {
                            setState(() {
                              isActive = value;
                            });
                          },
                          activeColor: AppColors.white,
                          activeTrackColor: AppColors.purpleColor,
                        ),
                      ),
                    ],
                  ),
                  30.heightBox,
                  CustomButton(text: "Create event", onTap: () {}),
                  24.heightBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
