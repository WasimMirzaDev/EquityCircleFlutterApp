import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html/parser.dart' as htmlParser;

class EducationCard extends StatelessWidget {
  final Map<String, dynamic> education;
  EducationCard({super.key, required this.education});

  final String? baseUrl = dotenv.env['API_URL'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.white,
          border: Border.all(color: AppColors.lightGreyColor, width: 0.28),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                                '$baseUrl/data/images/education/${education['image_path']}',
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
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor: AppColors.white.withOpacity(
                                    0.8,
                                  ),
                                  child: SvgPicture.asset(Assets.playIcon),
                                ),
                              ),
                            ),
                          ],
                        )
                        : const Icon(Icons.error, size: 20),
              ),
              10.heightBox,
              Text(
                education['title'],
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.inter,
                  color: AppColors.black,
                ),
              ),
              10.heightBox,
              Text(
                htmlParser
                        .parse(education['short_description'] ?? '')
                        .documentElement
                        ?.text ??
                    '',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.inter,
                  color: AppColors.darkGrey,
                ),
              ),
              12.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
