import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    required this.text,
    this.bgColor = AppColors.purpleColor,
    this.textColor = AppColors.white,
    required this.onTap,
    this.height = 36,
    this.width = double.infinity,
    this.borderColor = Colors.transparent,
    this.loading = false,
    this.textSize,
    super.key,
  });

  String text;
  Color textColor;
  Color bgColor;
  void Function() onTap;
  final bool loading;
  double height;
  final Color borderColor;
  double width;
  double? textSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (loading) return;
        onTap();
      },
      child: Container(
        height: height.h,
        width: width.w,

        decoration: BoxDecoration(
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
              Theme.of(context).brightness == Brightness.dark ? null : bgColor,
          border: Border.all(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Color(0x33FFFFFF)
                    : borderColor,
          ),

          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child:
              loading == true
                  ? LoadingIndicator(
                    radius: 10.r,
                    activeColor: AppColors.purpleColor,
                    inactiveColor: AppColors.greyColor,

                    animationDuration: Duration(milliseconds: 500),
                  )
                  : Text(
                    text,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                  ),
        ),
      ),
    );
  }
}
