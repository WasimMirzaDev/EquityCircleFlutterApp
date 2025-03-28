import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../widget/calender_card.dart';

class EventCalenderScreen extends StatefulWidget {
  const EventCalenderScreen({super.key});

  @override
  State<EventCalenderScreen> createState() => _EventCalenderScreenState();
}

class _EventCalenderScreenState extends State<EventCalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.offWhite,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: Text(
          "Events Calendar",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.inter,
            fontSize: 14.sp,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(Assets.backArrow, height: 20.h),
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            });
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(color: AppColors.lightGreyColor, height: 0.5.h),
            20.heightBox,

            ...List.generate(5, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                child: CalenderCardWidget(
                  discription: "Exploring the Future of AI and Blockchain",
                  status: "Public",
                  title: "Tech Innovation Meetup",
                  image: Assets.cryptoImg,
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              context.go('/addNewEvent');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: AppColors.purpleColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                child: Row(
                  children: [
                    Icon(Icons.add, color: AppColors.white, size: 16.sp),
                    Text(
                      "Add new event",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.inter,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding noEventFound() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.eventCalenderIcon),
          20.heightBox,
          Text(
            textAlign: TextAlign.center,
            "No events found. Click 'Add New Event' to create one!",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              fontFamily: AppFonts.inter,
              color: AppColors.blackGrey,
            ),
          ),
        ],
      ),
    );
  }
}
