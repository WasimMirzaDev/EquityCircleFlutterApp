import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/constants.dart'
    show PAGE_MARGIN_HOR;
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/appFonts.dart' show AppFonts;
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/theme_colors.dart';
import '../../../add_post/presentation/widget/discard_dialogbox.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Stack(
      children: [
        Positioned.fill(
          top: 400.h,
          child: SvgPicture.asset(
            Assets.drawerBg,
            fit: BoxFit.cover,
            height: 640.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              70.heightBox,
              Center(
                child: SvgPicture.asset(
                  Assets.logo,
                  height: 20.h,
                  color: ThemeColors.logoColor(context),
                ),
              ),
              24.heightBox,
              Divider(color: AppColors.lightGreyColor, height: 0.5),
              25.heightBox,
              drawerRow("Education", Assets.education, () {
                context.push('/neweducation');
              }, context),

              20.heightBox,

              drawerRow("Job List", Assets.jobList, () {
                context.go('/Joblist');
              }, context),
              20.heightBox,

              drawerRow("Job Application", Assets.jobApplication, () {
                context.go('/JobApplication');
              }, context),
              20.heightBox,

              drawerRow("Events Calendar", Assets.eventCalender, () {
                context.go('/EventCalender');
              }, context),
              20.heightBox,

              drawerRow("Notifications", Assets.notificationIcon, () {
                // context.go('/settings');
              }, context),
              20.heightBox,

              drawerRow("Mange Users", Assets.user, () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ManageUserScreen()),
                // );
              }, context),
              20.heightBox,
              drawerRow("Log out", Assets.logoutIcon, () {
                showDiscardDialog(
                  context,

                  "Log out",
                  "Are you sure you want to logout?",
                  "Cancel",
                  "Confirm",

                  () {
                    Navigator.pop(context, true);
                  },
                  () {
                    Provider.of<AuthProvider>(context, listen: false).logout();
                    context.go('/login');
                  },
                );
              }, context),

              Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    width: 32.w,
                    height: 32.h,
                    Assets.closeCircle,
                    color: ThemeColors.iconColor(context),
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              50.heightBox,
            ],
          ),
        ),
      ],
    );
  }

  Widget drawerRow(
    String title,
    String icon,
    VoidCallback onTap,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                // width: 40.w,
                // height: 200,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(255, 255, 255, 0.10), // 10% white
                      Color.fromRGBO(255, 255, 255, 0.01), // 1% white
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(
                        255,
                        255,
                        255,
                        0.05,
                      ), // 5% white shadow
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(
                    4.r,
                  ), // Optional, for rounded corners
                ),

                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    width: 20.w,
                    height: 20.h,
                    icon,
                    color:
                        title == "Log out"
                            ? Colors.red
                            : ThemeColors.iconColor(context),
                  ),
                ),
              ),
              10.widthBox,
              Text(
                title,
                style: TextStyle(
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w400,
                  color:
                      title == "Log out"
                          ? Colors.red
                          : ThemeColors.textColor(context),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            Assets.arrowRight,
            color: ThemeColors.commentfielIconsColor(context),
          ),
        ],
      ),
    );
  }
}
