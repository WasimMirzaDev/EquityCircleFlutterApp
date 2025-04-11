import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/theme_colors.dart' show ThemeColors;

class CustomSignInButton extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;
  final String buttonText;

  const CustomSignInButton({
    super.key,
    required this.onTap,
    required this.iconPath,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40..h,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: ThemeColors.background(context),
          border: Border.all(color: ThemeColors.borderColor(context)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 20.w,
              height: 20.h,
              fit: BoxFit.cover,
            ),
            10.widthBox,
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: AppFonts.inter,
                fontWeight: FontWeight.w400,
                color: ThemeColors.textColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
