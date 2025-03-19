import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/constants.dart'
    show PAGE_MARGIN_HOR;
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/appFonts.dart' show AppFonts;
import '../../../../core/constants/assets.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(Assets.drawerbg, fit: BoxFit.cover)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              70.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icon/Equity_Circle_icon.png",
                        height: 30.h,
                        width: 30.w,
                      ),
                      8.widthBox,
                      Text(
                        'Equity Circle',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      width: 24.w,
                      height: 24.h,
                      Assets.closeCircle,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              24.heightBox,
              Divider(color: AppColors.lightGreyColor, height: 0.5),
              25.heightBox,
              drawerRow("Educatiion", Assets.education, () {
                context.push('/education');
              }),

              30.heightBox,

              drawerRow("Job List", Assets.jobList, () {
                context.go('/Joblist');
              }),
              30.heightBox,

              drawerRow("Job Application", Assets.jobApplication, () {
                context.go('/feedback');
              }),
              30.heightBox,

              drawerRow("Events Calendar", Assets.eventCalender, () {
                context.go('/calendar');
              }),
              30.heightBox,

              drawerRow("Notifications", Assets.notificationIcon, () {
                context.go('/settings');
              }),
              30.heightBox,

              drawerRow("Mange Users", Assets.user, () {
                context.go('/Joblist');
              }),
              30.heightBox,

              // GestureDetector(
              //   onTap: () {
              //     Provider.of<AuthProvider>(context, listen: false).logout();
              //     context.go('/login');
              //   },
              //   child: ListTile(leading: Icon(Icons.logout), title: Text("Logout")),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget drawerRow(String title, String icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(width: 20.w, height: 20.h, icon),
              10.widthBox,
              Text(
                title,
                style: TextStyle(
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SvgPicture.asset(Assets.arrowRight),
        ],
      ),
    );
  }
}
