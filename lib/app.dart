import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/constants/theme_colors.dart';
import 'core/providers/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);

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
            themeMode: themeProvider.currentTheme,
            routerConfig: createRouter(authProvider), // ✅ Safe access now
          ),
    );
  }
}
