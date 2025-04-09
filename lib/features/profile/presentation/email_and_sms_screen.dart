import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/theme_colors.dart';

class EmailAndSmsScreen extends StatefulWidget {
  const EmailAndSmsScreen({super.key});

  @override
  _EmailAndSmsScreenState createState() => _EmailAndSmsScreenState();
}

class _EmailAndSmsScreenState extends State<EmailAndSmsScreen> {
  bool isEmailActive = true;
  bool isSmsActive = true;

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
          "Email and SMS",
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
            20.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  emailSmsRow(
                    context,
                    "Enable email notifications",
                    isEmailActive,
                    (value) {
                      setState(() {
                        isEmailActive = value;
                      });
                    },
                  ),
                  16.heightBox,
                  emailSmsRow(
                    context,
                    "Enable SMS notifications",
                    isSmsActive,
                    (value) {
                      setState(() {
                        isSmsActive = value;
                      });
                    },
                  ),
                  16.heightBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailSmsRow(
    BuildContext context,
    String text,
    bool switchValue,
    Function(bool) onChanged,
  ) {
    return Container(
      height: 38.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.lightGreyColor),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: AppFonts.inter,
                fontWeight: FontWeight.w500,
                color: ThemeColors.textColor(context),
              ),
            ),
            Transform.scale(
              scale: 0.6,
              child: Switch(
                value: switchValue,
                onChanged: onChanged,
                activeColor: ThemeColors.swtichDotColor(context),
                activeTrackColor: ThemeColors.swtichBgColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
