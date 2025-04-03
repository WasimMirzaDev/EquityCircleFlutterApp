import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showApplicantDetailsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Applicant Details",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.inter,
                    color: AppColors.black,
                  ),
                ),
              ),
              10.heightBox,
              Divider(color: AppColors.lightGreyColor, height: 0.5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    10.heightBox,
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 21.r,
                          backgroundColor: AppColors.purpleColor,
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundImage: AssetImage(Assets.dp),
                          ),
                        ),
                      ],
                    ),
                    10.heightBox,
                    Text(
                      "Susan Sumanggih",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.inter,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "Sales and Growth Executive",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.inter,
                        color: AppColors.blackGrey,
                      ),
                    ),
                    30.heightBox,
                    _buildInfoField("Email", "Susan@email.com"),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(child: _buildInfoField("Country", "Pakistan")),
                        8.widthBox,
                        Expanded(child: _buildInfoField("Company", "Devsinc")),
                      ],
                    ),
                    10.heightBox,

                    _buildInfoField("Application Status", "Pending"),
                    20.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 32.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: AppColors.lightGreyColor,
                                  width: 0.5.w,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "View Profile",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppFonts.inter,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        10.widthBox,
                        Expanded(
                          child: Container(
                            height: 32.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.purpleColor,
                            ),
                            child: Center(
                              child: Text(
                                "View CV",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.inter,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.heightBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildInfoField(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.inter,
          color: AppColors.blackGrey,
        ),
      ),
      6.heightBox,
      Container(
        height: 32.h,
        width: double.infinity,

        decoration: BoxDecoration(
          color: AppColors.extralightgrey,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.inter,
                color: AppColors.blackGrey,
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
    ],
  );
}
