import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/appFonts.dart';

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
                border: Border.all(color: AppColors.lightGreyColor, width: 1.w),
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

                color: AppColors.purpleColor,
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
