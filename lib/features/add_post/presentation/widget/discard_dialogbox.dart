import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/appColors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/theme_colors.dart';

Future<void> showDiscardDialog(
  BuildContext context,
  String title,
  String discription,
  cancelText,
  confirmText,
  VoidCallback cancelOntap,
  VoidCallback confirmOntap,
) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ThemeColors.background(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            5.heightBox,
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  Assets.close,

                  color: ThemeColors.iconColor(context),
                ),
              ),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.textColor(context),
                ),
              ),
            ),
            14.heightBox,
            Text(
              discription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: AppFonts.inter,
                fontWeight: FontWeight.w400,
                color: ThemeColors.subtitleColor(context),
              ),
            ),

            20.heightBox,

            Padding(
              padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: cancelOntap,
                      child: Container(
                        height: 26.h,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: ThemeColors.discardBorderColor(context),
                          ),
                          color: ThemeColors.discardBtnBg(context),
                        ),

                        child: Center(
                          child: Text(
                            cancelText,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: AppFonts.inter,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.discardBorderColor(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  10.widthBox,
                  Expanded(
                    child: GestureDetector(
                      onTap: confirmOntap,
                      child: Container(
                        height: 26.h,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),

                          color: AppColors.red,
                        ),

                        child: Center(
                          child: Text(
                            confirmText,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: AppFonts.inter,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
