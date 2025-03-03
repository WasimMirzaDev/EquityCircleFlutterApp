import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/core/providers/feeds_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router.dart'; // Import the router file

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light, // Set theme brightness
        primary: Color(0xFF6043D1), // Bottom active navigation bar color
        onPrimary: Colors.white, // Text/icons on primary color
        secondary: Color(0xFF897FFF), // Business badge gradient end color
        onSecondary: Colors.white, // Text/icons on secondary color
        background: Color(0xFFEBEAF0), // Background color
        onBackground: Colors.black, // Text color on background
        surface: Colors.white, // Card background color
        onSurface: Colors.black, // Text color on card surface
        error: Colors.red, // Error color
        onError: Colors.white, // Text color on error
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(
        0xFFEBEAF0,
      ), // Set app background color
      cardColor: Colors.white, // Set card background color
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black), // General text color
        bodyMedium: TextStyle(color: Color(0xFF7A7F88)), // Light text color
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FeedsProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: MaterialApp.router(
        title: 'Equity Circle App',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        routerConfig:
            router, // ✅ Use `routerConfig` instead of `routerDelegate`
      ),
    );
  }
}
