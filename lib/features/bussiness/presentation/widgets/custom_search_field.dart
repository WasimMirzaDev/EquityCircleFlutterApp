import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/assets.dart' show Assets;
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

CustomTextField customSearchWidget(
  String text,
  TextEditingController controller,
) {
  return CustomTextField(
    controller: controller,
    hint: "  Search for users",
    prefixIcon: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        12.widthBox,
        SvgPicture.asset(Assets.searchIcon, height: 14.h),
        12.widthBox,
        SizedBox(
          height: 12.h,
          child: const VerticalDivider(width: 1, color: AppColors.black),
        ),
      ],
    ),
  );
}
