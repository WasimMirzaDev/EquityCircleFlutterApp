import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/appFonts.dart';
import '../constants/theme_colors.dart';

void showTopSnackbar(BuildContext context, String message, bool isSuccess) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder:
        (context) => Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16,
          right: 16,
          child: Material(
            color: AppColors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color:
                    isSuccess
                        ? ThemeColors.successSnack(context)
                        : AppColors.red,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.black,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    isSuccess ? Icons.check_circle : Icons.error,
                    color: AppColors.white,
                    size: 20,
                  ),
                  10.widthBox,
                  Expanded(
                    child: Text(
                      message,

                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 1), () {
    overlayEntry.remove();
  });
}
