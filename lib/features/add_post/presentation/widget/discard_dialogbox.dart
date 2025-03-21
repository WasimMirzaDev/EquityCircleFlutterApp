import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/appColors.dart';
import '../../../../core/constants/constants.dart';

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
                child: SvgPicture.asset(Assets.close),
              ),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
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
                color: AppColors.darkGrey,
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
                          border: Border.all(color: AppColors.purpleColor),
                          color: AppColors.white,
                        ),

                        child: Center(
                          child: Text(
                            cancelText,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: AppFonts.inter,
                              fontWeight: FontWeight.w400,
                              color: AppColors.purpleColor,
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

                          color: AppColors.purpleColor,
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
