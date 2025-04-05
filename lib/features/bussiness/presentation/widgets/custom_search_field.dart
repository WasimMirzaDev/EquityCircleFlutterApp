import 'package:equitycircle/core/constants/assets.dart' show Assets;
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/theme_colors.dart';

CustomTextField customSearchWidget(
  String text,
  TextEditingController controller,
  BuildContext context,
) {
  return CustomTextField(
    controller: controller,
    hint: "  Search for users",
    fillColor: ThemeColors.search(context),

    prefixIcon: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        12.widthBox,
        SvgPicture.asset(
          Assets.searchIcon,
          height: 14.h,

          color: ThemeColors.iconColor(context),
        ),
        12.widthBox,
        SizedBox(
          height: 12.h,
          child: VerticalDivider(
            width: 1,
            color: ThemeColors.iconColor(context),
          ),
        ),
      ],
    ),
  );
}
