import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final nextRoute = authProvider.isAuthenticated ? '/' : '/login';
      GoRouter.of(context).go(nextRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.background(context),
      body: Center(
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
    );
  }
}
