import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NoBusinessInsights extends StatelessWidget {
  String icon;
  String text;
  NoBusinessInsights({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 36.h,
              width: 36.w,
              color: AppColors.black,
            ),
            10.heightBox,
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.inter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
