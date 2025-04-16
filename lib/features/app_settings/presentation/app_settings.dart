import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/theme_colors.dart' show ThemeColors;
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/appColors.dart';
import '../../../core/constants/assets.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../profile/widgets/custom_two_buttons.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({super.key});

  @override
  _AppSettingScreenState createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  String activeMenuStyle = 'Rounded One';
  String direction = 'Left to Right';

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        title,
        style: TextStyle(
          color: ThemeColors.textColor(context),
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.inter,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _button(String text, {bool selected = false, VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Container(
            height: 30.h,
            decoration: BoxDecoration(
              color:
                  selected
                      ? Theme.of(context).brightness == Brightness.dark
                          ? null
                          : AppColors.purpleColor
                      : ThemeColors.postCatagoriesBox(context),
              gradient:
                  Theme.of(context).brightness == Brightness.dark && selected
                      ? const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x80FFFFFF), // 50% opacity
                          Color(0x1AFFFFFF),
                        ],
                      )
                      : null,
              borderRadius: BorderRadius.circular(4.r),
              border:
                  selected
                      ? null
                      : Border.all(color: ThemeColors.borderColor(context)),
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                color:
                    selected ? AppColors.white : ThemeColors.textColor(context),
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.inter,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _colorButton(List<Color> colors) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        height: 30.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: ThemeColors.borderColor(context)),
          gradient: LinearGradient(colors: colors),
        ),
      ),
    );
  }

  Widget _radioTile(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: label,
          activeColor: ThemeColors.radiobtn(context),
          groupValue: activeMenuStyle,
          onChanged: (value) {
            setState(() {
              activeMenuStyle = value!;
            });
          },
        ),
        Text(
          label,
          style: TextStyle(
            color: ThemeColors.textColor(context),
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.inter,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration:
          isDarkMode
              ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.postFormBg),
                  fit: BoxFit.fill,
                ),
              )
              : BoxDecoration(color: AppColors.white),
      child: Scaffold(
        backgroundColor: AppColors.transparent,

        appBar: CustomAppBar(
          title: "App Setting",
          onLeadingPressed: () {
            Navigator.pop(context);
          },
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: ThemeColors.borderColor(context),
                thickness: 0.5.h,
              ),
              16.heightBox,
              _sectionTitle('Select Theme'),
              8.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    _button('Light Theme', selected: true),
                    _button('Dark Theme'),
                    _button('Device Default'),
                  ],
                ),
              ),
              16.heightBox,
              Divider(
                color: ThemeColors.borderColor(context),
                thickness: 0.5.h,
              ),
              16.heightBox,
              _sectionTitle('Menu Style'),
              8.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    _button('Mini', selected: true),
                    _button('Hover'),
                    _button('Soft'),
                  ],
                ),
              ),
              16.heightBox,
              Divider(
                color: ThemeColors.borderColor(context),
                thickness: 0.5.h,
              ),
              16.heightBox,
              _sectionTitle('Active Menu Style'),
              8.heightBox,
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  _radioTile('Rounded One'),
                  _radioTile('Rounded All'),
                  _radioTile('Pill One Side'),
                  _radioTile('Pill All'),
                ],
              ),
              16.heightBox,
              Divider(
                color: ThemeColors.borderColor(context),
                thickness: 0.5.h,
              ),
              16.heightBox,
              _sectionTitle('Color Customizer'),
              8.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    _colorButton([Colors.pink, Colors.blue]),
                    _colorButton([Colors.orange, Colors.blue]),
                    _colorButton([Colors.purple, Colors.red]),
                  ],
                ),
              ),
              16.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    _colorButton([Colors.blueGrey, Colors.blue]),
                    _button('Custom'),
                  ],
                ),
              ),
              16.heightBox,
              Divider(
                color: ThemeColors.borderColor(context),
                thickness: 0.5.h,
              ),
              16.heightBox,
              _sectionTitle('Direction'),
              8.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    _button(
                      'Left to Right',
                      selected: direction == 'Left to Right',
                      onTap: () => setState(() => direction = 'Left to Right'),
                    ),
                    _button(
                      'Right To Left',
                      selected: direction == 'Right To Left',
                      onTap: () => setState(() => direction = 'Right To Left'),
                    ),
                  ],
                ),
              ),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
