import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_appbar.dart' show CustomAppBar;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          title: "Email and SMS",
          onLeadingPressed: () {
            Navigator.pop(context);
          },
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: ThemeColors.borderColor(context),
                thickness: 0.5.h,
              ),
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
        border: Border.all(color: ThemeColors.borderColor(context)),
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
