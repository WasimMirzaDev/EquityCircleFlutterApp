import 'package:equitycircle/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:equitycircle/router.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return MaterialApp.router(
      title: 'Equity Circle App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: createRouter(authProvider), // ✅ Safe access now
    );
  }
}
