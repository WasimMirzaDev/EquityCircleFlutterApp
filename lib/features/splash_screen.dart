import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/appColors.dart';
import '../core/constants/assets.dart';
import '../core/constants/theme_colors.dart';
import '../core/widgets/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // final authProvider = Provider.of<AuthProvider>(context, listen: false);
      // final nextRoute = authProvider.isAuthenticated ? '/' : '/login';
      context.go('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration:
            isDarkMode
                ? BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.splashBg),
                    fit: BoxFit.cover,
                  ),
                )
                : null,
        color: isDarkMode ? null : AppColors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              50.heightBox,
              SvgPicture.asset(
                Assets.logo,
                height: 30.h,
                color: ThemeColors.logoColor(context),
              ),
              Spacer(),
              LoadingIndicator(
                radius: 20.r,
                activeColor: ThemeColors.indicatorColor(context),
                inactiveColor: AppColors.greyColor,
                animationDuration: Duration(milliseconds: 1200),
              ),
              50.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
