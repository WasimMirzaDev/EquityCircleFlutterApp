import 'package:flutter/material.dart';

import 'appColors.dart';

class ThemeColors {
  // Dynamic color getters
  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.pureBlack
          : AppColors.white;
  static Color logoColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : AppColors.black;
  static Color indicatorColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.black
          : AppColors.purpleColor;
  static Color carousalIndicatorColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : AppColors.purpleColor;
  static Color appbar(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.black
          : AppColors.offWhite;
  static Color bottomNavText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : AppColors.purpleColor;
  static Color search(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkblack
          : AppColors.offWhite;
  static Color attachmentContainerColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkblack
          : AppColors.babyPink;
  static Color cardColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkblack
          : AppColors.white;
  static Color dottedColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : AppColors.purpleColor;
  static Color iconColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : AppColors.black;
  static Color hintTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkGrey
          : AppColors.darkGrey;
  static Color textColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : AppColors.black;
  static Color radiobtn(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkGrey
          : AppColors.purpleColor;
  static Color subTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkGrey
          : AppColors.darkGrey;

  static Color borderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkblack
          : AppColors.lightGreyColor;
  static Color subjCardColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.black
          : AppColors.purpleColor;
  static Color subjTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkGrey
          : AppColors.white;
  static Color tabBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.lightBlack
          : AppColors.lightorange;

  static Color tabTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : AppColors.orange;
  static Color commentBgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.blackGreyDark
          : AppColors.fieldgrey;
  static Color commenttextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : AppColors.darkGrey;
  static Color commentfielIconsColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : AppColors.darkGrey;
  static Color postCatagoriesBox(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkblack
          : AppColors.white;
  static Color sendBgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkThemeGrey
          : AppColors.purpleColor;
  static Color sendIconColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.pureBlack
          : AppColors.white;
  static Color postTypeTextIconColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.pureBlack
          : AppColors.white;
  static Color swtichBgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : AppColors.purpleColor;
  static Color swtichDotColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.pureBlack
          : AppColors.white;
  static Color discardBtnBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkblack
          : AppColors.white;
  static Color discardBorderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.lime
          : AppColors.purpleColor;
  static Color subtitleColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : AppColors.darkGrey;

  static Color fabAddIcon(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.pureBlack
          : AppColors.white;
  static Color loginColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkGrey
          : AppColors.purpleColor;
  static Color successSnack(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkGrey
          : AppColors.purpleColor;
  static Color bottomNavColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkGrey
          : AppColors.purpleColor;
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.orange,
    cardColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: AppColors.black),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColors.black)),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.blackGrey,
    primaryColor: AppColors.orange,
    cardColor: AppColors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColors.white)),
  );
}
