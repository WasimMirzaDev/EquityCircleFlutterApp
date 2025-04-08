import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/appColors.dart';
import '../constants/theme_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObscure;
  final bool isEditable;
  final bool readOnly;
  final bool autoFocus;
  final double? fieldVerticalPadding;
  final double? fieldHorizontalPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormat;
  final int? maxLines;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator; // Input validator function
  final FocusNode? focusNode;

  Color? fillColor = AppColors.white;
  CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.isObscure = false,
    this.isEditable = true,
    this.readOnly = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.fieldVerticalPadding,
    this.fieldHorizontalPadding,
    this.textAlign,
    this.inputFormat,
    this.fillColor,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.suffixIcon,
    this.onTap,
    this.keyBoardType,
    this.validator,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.transparent,
          selectionHandleColor: Colors.transparent,
        ),
      ),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        readOnly: readOnly,
        obscureText: isObscure,
        keyboardType: keyBoardType,
        enabled: isEditable,
        validator: validator,
        style: TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: ThemeColors.textColor(context),
        ),
        textAlign: textAlign ?? TextAlign.left,
        focusNode: focusNode,
        autofocus: autoFocus,
        cursorColor: ThemeColors.textColor(context),
        maxLines: maxLines,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        inputFormatters: inputFormat,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: fillColor ?? AppColors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColors.borderColor(context),

              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColors.borderColor(context),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: AppFonts.inter,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: ThemeColors.hintTextColor(context),
          ),
          suffixIconConstraints: BoxConstraints(maxHeight: 43.h),
          prefixIconConstraints: BoxConstraints(maxHeight: 35.h),
          errorStyle: TextStyle(),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
