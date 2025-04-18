import 'package:equitycircle/core/constants/theme_colors.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_textfield.dart'
    show CustomTextField;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/appFonts.dart';
import '../../../core/constants/assets.dart';
import '../../../core/models/feeds_model.dart';
import '../../bussiness/presentation/widgets/custom_post_container.dart';

class TimeLineTab extends StatelessWidget {
  final TextEditingController postController;
  const TimeLineTab({super.key, required this.postController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          16.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: ThemeColors.borderColor(context),
                  width: 0.5,
                ),
                color: ThemeColors.cardColor(context),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundImage: AssetImage(Assets.dp),
                        ),
                        10.widthBox,
                        Expanded(
                          child: CustomTextField(
                            controller: postController,
                            hint: "Start a post",
                            fillColor: ThemeColors.search(context),
                          ),
                        ),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _PostIcon(label: 'Photos', icon: Assets.pictureIcon),
                        5.widthBox,
                        _PostIcon(label: 'Videos', icon: Assets.videoPostIcon),
                        5.widthBox,
                        _PostIcon(label: 'Jobs', icon: Assets.jobIcon),
                        5.widthBox,
                        _PostIcon(label: 'Events', icon: Assets.eventPostIcon),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          10.heightBox,
          ...List.generate(5, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: customPostContainer(
                DataByFeed(),
                0,
                1,
                'https://images.unsplash.com/photo-1575936123452-b67c3203c357?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
                'John Doe',
                'April 16, 2025',
                'This is a dummy post description for testing purpose.',
                () => print("Comment tapped"),
                () => print("Like tapped"),
                'Business',
                Colors.blue.shade100,
                Colors.blue,
                [
                  MediaByFeeds(
                    url:
                        'https://images.unsplash.com/photo-1575936123452-b67c3203c357?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
                  ),
                ],
                context,
                List.generate(3, (i) => 'Like $i'),
                index % 2 == 0,
                List.generate(2, (i) => 'Comment $i'),
                true,
              ),
            );
          }),
          10.heightBox,
        ],
      ),
    );
  }
}

class _PostIcon extends StatelessWidget {
  final String label;
  final String icon;

  const _PostIcon({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        8.widthBox,
        Text(
          label,
          style: TextStyle(
            color: ThemeColors.subTextColor(context),
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.inter,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
