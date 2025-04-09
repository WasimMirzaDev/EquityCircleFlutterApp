import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/theme_colors.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_textfield.dart';
import 'widget/custom_dropdown.dart';

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
  final quill.QuillController _controller = quill.QuillController.basic();
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
          title: "Create new event",
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
                      "Event type*",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomDropdown(
                      controller: eventTypeController,
                      selectedValue: eventTypeController.text,
                      items: eventTypes,
                      onChanged: (newValue) {
                        setState(() {
                          eventTypeController.text = newValue!;
                        });
                      },
                      hintText: "Select Event Type",
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
                      "Subtitle*",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: subtitleController,
                      hint: "Enter subtitle",
                      fillColor: ThemeColors.search(context),
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
                    16.heightBox,
                    Text(
                      "Event date*",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: eventDateController,
                      fillColor: ThemeColors.search(context),
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
                        color: ThemeColors.textColor(context),
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
                              fillColor: ThemeColors.search(context),
                              hint: "Start time",
                              onTap:
                                  () =>
                                      _selectTime(context, startDateController),
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
                              fillColor: ThemeColors.search(context),
                              onTap:
                                  () => _selectTime(context, endDateController),
                              hint: "End time",
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
                            color: ThemeColors.textColor(context),
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
                            activeColor: ThemeColors.swtichDotColor(context),
                            activeTrackColor: ThemeColors.swtichBgColor(
                              context,
                            ),
                          ),
                        ),
                      ],
                    ),
                    30.heightBox,
                    CustomButton(
                      text: "Create event",
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
}
