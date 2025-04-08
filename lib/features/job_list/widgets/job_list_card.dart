import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart' as htmlParser;

import '../../../core/constants/theme_colors.dart';

class JobCardWidget extends StatelessWidget {
  // final Job job;

  String image;
  String title;
  String discription;
  bool? readMore = false;

  JobCardWidget({
    super.key,
    // required this.job,
    required this.discription,
    required this.title,
    required this.image,
    this.readMore,
  });

  final String? baseUrl = dotenv.env['API_URL'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: ThemeColors.cardColor(context),
        border: Border.all(
          color: ThemeColors.borderColor(context),
          width: 0.28,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Makes sure Card wraps content
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child:
                  baseUrl != null
                      ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Image.network(
                              '$baseUrl/images/$image',
                              fit:
                                  BoxFit
                                      .cover, // Makes image fit the card properly
                              width: double.infinity,
                              height: 170.h,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  size: 100,
                                ); // Fallback if image fails
                              },
                            ),
                          ),

                          Positioned(
                            top: 8,
                            left: 8,
                            // right: 0,
                            // bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(56.r),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 5.h,
                                  ),
                                  child: Text(
                                    "Active 20 days ago",
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: AppFonts.inter,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : const Icon(Icons.error, size: 20),
            ),
            10.heightBox,
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.inter,
                color: ThemeColors.textColor(context),
              ),
            ),
            10.heightBox,
            Text(
              htmlParser.parse(discription).documentElement?.text ?? '',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.inter,
                color: ThemeColors.subTextColor(context),
              ),
            ),

            12.heightBox,
            readMore == false
                ? SizedBox.fromSize()
                : Row(
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
                            "Read More",
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
                  ],
                ),
            12.heightBox,
          ],
        ),
      ),
    );
  }
}
