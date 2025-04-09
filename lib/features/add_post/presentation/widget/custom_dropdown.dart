import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/theme_colors.dart' show ThemeColors;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/appColors.dart';
import '../../../../core/constants/assets.dart';

class CustomDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final void Function(String?) onChanged;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomDropdown({
    super.key,
    required this.controller,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.hintText = "Select",
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      style: TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.darkGrey,
      ),
      icon: const SizedBox.shrink(),
      value: items.contains(controller.text) ? controller.text : null,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: ThemeColors.search(context),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.lightGreyColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.lightGreyColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        hintText: hintText,
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
                color: ThemeColors.iconColor(context),
              ),
            ],
          ),
        ),
        suffixIconConstraints: const BoxConstraints(maxHeight: 43),
        prefixIconConstraints: const BoxConstraints(maxHeight: 35),
      ),
      items:
          items.map((String value) {
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
      onChanged: onChanged,
      validator: validator,
    );
  }
}
