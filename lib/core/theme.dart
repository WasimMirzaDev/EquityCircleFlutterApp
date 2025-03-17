import 'package:flutter/material.dart';

import 'constants/appColors.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light, // Set theme brightness
    primary: AppColors.purpleColor, // Bottom active navigation bar color
    onPrimary: AppColors.white, // Text/icons on primary color
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
  scaffoldBackgroundColor: const Color(0xFFEBEAF0), // Set app background color
  cardColor: Colors.white, // Set card background color
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black), // General text color
    bodyMedium: TextStyle(color: Color(0xFF7A7F88)), // Light text color
  ),
);
