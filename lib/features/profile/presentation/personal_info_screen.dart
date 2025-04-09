import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/appColors.dart';
import '../../../core/constants/appFonts.dart';
import '../../../core/constants/theme_colors.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../add_post/presentation/widget/custom_dropdown.dart';
import '../widgets/custom_two_buttons.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  String? _selectedCountry;
  String? _selectedState;
  String _maritalStatus = 'Single';
  String _ageGroup = '25-30';
  String _gender = 'Male';

  @override
  void dispose() {
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

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
          "Personal Info",
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
            Divider(color: AppColors.lightGreyColor, thickness: 0.5.h),
            16.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(),
                  SizedBox(height: 40),
                  16.heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "First name:",
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
                              hint: "Enter First name",
                              fillColor: ThemeColors.search(context),
                            ),
                          ],
                        ),
                      ),
                      12.widthBox,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last name:",
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
                              hint: "Enter Last name",
                              fillColor: ThemeColors.search(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  16.heightBox,
                  Text(
                    "User name:",
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
                    hint: "Enter User name",
                    fillColor: ThemeColors.search(context),
                  ),
                  16.heightBox,
                  Text(
                    "City:",
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
                    hint: "Enter City",
                    fillColor: ThemeColors.search(context),
                  ),
                  16.heightBox,
                  Text(
                    "Gender:",
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
                      Expanded(child: _buildRadio("Male")),
                      12.widthBox,
                      Expanded(child: _buildRadio("Female")),
                    ],
                  ),
                  16.heightBox,
                  Text(
                    "Date of birth",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.textColor(context),
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: _dobController,
                    fillColor: ThemeColors.search(context),
                    hint: "dd/mm/yyyy",
                    onTap: () => _selectDate(context),

                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SvgPicture.asset(Assets.calendar),
                    ),
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
                              "Marital status:",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: AppFonts.inter,
                                fontWeight: FontWeight.w400,
                                color: ThemeColors.textColor(context),
                              ),
                            ),
                            8.heightBox,
                            CustomDropdown(
                              controller: TextEditingController(
                                text: _maritalStatus,
                              ),
                              selectedValue: _maritalStatus,
                              items: ["Single", "Married"],
                              onChanged:
                                  (val) =>
                                      setState(() => _maritalStatus = val!),
                              hintText: "Marital status",
                            ),
                          ],
                        ),
                      ),
                      12.widthBox,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Age group:",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: AppFonts.inter,
                                fontWeight: FontWeight.w400,
                                color: ThemeColors.textColor(context),
                              ),
                            ),
                            8.heightBox,
                            CustomDropdown(
                              controller: TextEditingController(
                                text: _ageGroup,
                              ),
                              selectedValue: _ageGroup,
                              items: ["18-24", "25-30", "31-40", "40+"],
                              onChanged:
                                  (val) => setState(() => _ageGroup = val!),
                              hintText: "Age group",
                            ),
                          ],
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
                              "Country:",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: AppFonts.inter,
                                fontWeight: FontWeight.w400,
                                color: ThemeColors.textColor(context),
                              ),
                            ),
                            8.heightBox,
                            CustomDropdown(
                              controller: TextEditingController(
                                text: _selectedCountry,
                              ),
                              selectedValue: _selectedCountry,
                              items: ["Pakistan", "India"],
                              onChanged:
                                  (val) =>
                                      setState(() => _selectedCountry = val!),
                              hintText: "Country",
                            ),
                          ],
                        ),
                      ),
                      12.widthBox,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "State:",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: AppFonts.inter,
                                fontWeight: FontWeight.w400,
                                color: ThemeColors.textColor(context),
                              ),
                            ),
                            8.heightBox,
                            CustomDropdown(
                              controller: TextEditingController(
                                text: _selectedState,
                              ),
                              selectedValue: _selectedState,
                              items: ["Punjab", "Sindh"],
                              onChanged:
                                  (val) =>
                                      setState(() => _selectedState = val!),
                              hintText: "State",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Address:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.textColor(context),
                    ),
                  ),
                  8.heightBox,
                  CustomTextField(
                    controller: _addressController,
                    hint: "Enter Address",
                    maxLines: 3,
                    fillColor: ThemeColors.search(context),
                  ),
                  20.heightBox,
                  CustomTwoButtonsRow(
                    cancelText: "Cancel",
                    confirmText: "Save",
                  ),
                  50.heightBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadio(String gender) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ThemeColors.borderColor(context), width: 0.5),
      ),

      child: Row(
        children: [
          Radio<String>(
            activeColor: AppColors.purpleColor,

            value: gender,
            groupValue: _gender,
            onChanged: (val) => setState(() => _gender = val!),
          ),
          Text(
            gender,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: AppFonts.inter,
              fontWeight: FontWeight.w400,
              color: ThemeColors.textColor(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String? currentValue,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items:
          options
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
      onChanged: onChanged,
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 135.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            image: DecorationImage(
              image: AssetImage(Assets.carousalImg),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            height: 16.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: AppColors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  Text(
                    "Edit Cove",
                    style: TextStyle(
                      fontSize: 7.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: ThemeColors.textColor(context),
                    ),
                  ),
                  3.widthBox,
                  SvgPicture.asset(Assets.editIcon),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -32,
          left: 16,
          child: CircleAvatar(
            radius: 40.r,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 36.r,
              backgroundImage: AssetImage(Assets.dp),
              child: CircleAvatar(
                radius: 8.r,
                backgroundColor: Colors.white.withOpacity(0.6),
                child: SvgPicture.asset(Assets.editIcon),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
