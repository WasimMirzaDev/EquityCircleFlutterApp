import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/appFonts.dart';
import '../../../core/constants/theme_colors.dart';

class CustomTwoButtonsRow extends StatelessWidget {
  String cancelText;
  String confirmText;
  CustomTwoButtonsRow({
    super.key,
    required this.cancelText,
    required this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            child: Container(
              height: 32.h,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: ThemeColors.borderColor(context),
                  width: 1.w,
                ),
                color: AppColors.white,
              ),

              child: Center(
                child: Text(
                  cancelText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: AppFonts.inter,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        10.widthBox,
        Expanded(
          child: GestureDetector(
            child: Container(
              height: 32.h,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),

                gradient:
                    Theme.of(context).brightness == Brightness.dark
                        ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x80FFFFFF), // 50% opacity
                            Color(0x1AFFFFFF),
                          ],
                        )
                        : null,

                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? null
                        : AppColors.purpleColor,
                border: Border.all(
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Color(0x33FFFFFF)
                          : AppColors.lightGreyColor,
                ),
              ),

              child: Center(
                child: Text(
                  confirmText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: AppFonts.inter,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
