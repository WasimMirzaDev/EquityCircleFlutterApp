import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/theme_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLeadingPressed;
  final VoidCallback? onActionPressed;
  final Widget? actionIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onLeadingPressed,
    this.onActionPressed,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: Colors.transparent,
      shadowColor: ThemeColors.textColor(context),
      surfaceTintColor: ThemeColors.textColor(context),
      title: Text(
        title,
        style: TextStyle(
          color: ThemeColors.textColor(context),
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.inter,
          fontSize: 14.sp,
        ),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(
          Assets.backArrow,
          height: 20.h,
          color: ThemeColors.iconColor(context),
        ),
        onPressed: onLeadingPressed ?? () => Navigator.pop(context),
      ),
      actions: [
        if (actionIcon != null)
          IconButton(icon: actionIcon!, onPressed: onActionPressed),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
