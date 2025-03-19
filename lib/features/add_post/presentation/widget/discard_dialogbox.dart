import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/appColors.dart';

Future<void> showDiscardDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          "Discard Changes?",
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: AppFonts.inter,
            fontWeight: FontWeight.w500,
            color: AppColors.darkGrey,
          ),
        ),
        content: Text(
          "Are you sure you want to discard your changes? All unsaved modifications will be lost.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: AppFonts.inter,
            fontWeight: FontWeight.w400,
            color: AppColors.darkGrey,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Container(
              height: 82.h,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: AppColors.purpleColor),
                color: AppColors.white,
              ),

              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Container(
              height: 82.h,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),

                color: AppColors.purpleColor,
              ),

              child: Text(
                "Discard",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
