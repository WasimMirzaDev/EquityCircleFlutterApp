import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../features/feeds/helpers/picture_helpers.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../constants/appColors.dart';
import '../constants/constants.dart';
import '../constants/theme_colors.dart';
import '../providers/auth_provider.dart';

class HomePageCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomePageCustomAppBar({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return AppBar(
      centerTitle: true,

      backgroundColor: Colors.transparent,
      elevation: 0,
      // backgroundColor: ThemeColors.background(context),
      leading: Padding(
        padding: EdgeInsets.only(left: PAGE_MARGIN_HOR),
        child: IconButton(
          icon: SvgPicture.asset(
            Assets.drawerIcon,
            color: ThemeColors.iconColor(context),
          ),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      title: SvgPicture.asset(
        Assets.logo,
        height: 16.h,
        color: ThemeColors.logoColor(context),
      ),
      actions: [
        16.widthBox,
        SvgPicture.asset(
          width: 24.w,
          height: 24.h,
          Assets.notificationIcon,
          color: ThemeColors.iconColor(context),
        ),
        14.widthBox,
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          child: Container(
            width: 30.r,
            height: 30.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.purpleColor, width: 1.w),
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.lightGreyColor,
              radius: 20.r,
              backgroundImage: NetworkImage(
                getProfileImageUrl(authProvider.userData),
              ),
            ),
          ),
        ),
        16.widthBox,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
