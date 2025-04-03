import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'applicant_detail_bottomsheet.dart';

// ignore: must_be_immutable
class JobApplicationCardWidget extends StatelessWidget {
  // final Job job;

  String title;
  String status;
  Color statucTextColor;
  Color statucBGColor;
  String applicateName;
  String appliedDate;
  JobApplicationCardWidget({
    super.key,
    required this.status,
    required this.title,
    required this.statucBGColor,
    required this.statucTextColor,
    required this.applicateName,
    required this.appliedDate,
  });

  final String? baseUrl = dotenv.env['API_URL'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: AppColors.white,
        border: Border.all(color: AppColors.lightGreyColor, width: 0.28),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Makes sure Card wraps content
          children: [
            12.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: statucBGColor,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFonts.inter,
                          color: statucTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(Assets.moreVert),
              ],
            ),
            10.heightBox,
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.inter,
                color: AppColors.black,
              ),
            ),
            10.heightBox,

            applicantRow("Applicate:", applicateName),
            2.heightBox,
            applicantRow("Applied on:", appliedDate),
            12.heightBox,
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: AppColors.purpleColor,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h,
                      ),
                      child: Text(
                        "View Job Details",
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.inter,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                10.widthBox,
                GestureDetector(
                  onTap: () {
                    showApplicantDetailsBottomSheet(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: AppColors.purpleColor,
                        width: 0.5.w,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 5.h,
                        ),
                        child: Text(
                          "View Applicant Details",
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFonts.inter,
                            color: AppColors.purpleColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            12.heightBox,
          ],
        ),
      ),
    );
  }

  Row applicantRow(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.inter,
            color: AppColors.black,
          ),
        ),
        5.widthBox,
        Text(
          value,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.inter,
            color: AppColors.darkGrey,
          ),
        ),
      ],
    );
  }
}
