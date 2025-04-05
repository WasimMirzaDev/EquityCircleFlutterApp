import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/constants/theme_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: false,
      splitScreenMode: false,
      builder:
          (context, child) => MaterialApp.router(
            localizationsDelegates: [
              FlutterQuillLocalizations.delegate, // Add this line
            ],
            supportedLocales: const [
              Locale('en'), // Add any other locales you need
            ],
            title: 'Equity Circle App',
            debugShowCheckedModeBanner: false,

            theme: ThemeColors.lightTheme,
            darkTheme: ThemeColors.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: createRouter(authProvider), // ✅ Safe access now
          ),
    );
  }
}
