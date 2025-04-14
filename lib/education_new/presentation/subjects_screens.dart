import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_appbar.dart' show CustomAppBar;
import 'package:equitycircle/features/bussiness/presentation/widgets/custom_search_field.dart'
    show customSearchWidget;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../core/constants/theme_colors.dart';

class CategoryItem {
  final String title;
  final String imagePath;
  final DateTime startDate;
  final DateTime? endDate;
  final String code;
  final String ticketStatus;

  CategoryItem({
    required this.title,
    required this.imagePath,
    required this.startDate,
    this.endDate,
    required this.code,
    required this.ticketStatus,
  });

  String get formattedDate {
    final formatter = DateFormat('dd-MM-yyyy');
    if (endDate != null) {
      return '${formatter.format(startDate)} to ${formatter.format(endDate!)}';
    }
    return formatter.format(startDate);
  }
}

class SubjectScreen extends StatelessWidget {
  final List<CategoryItem> categories = [
    CategoryItem(
      title: 'Online Courses',
      imagePath: Assets.carousalImg,
      startDate: DateTime(2025, 4, 5),
      endDate: DateTime(2025, 4, 6),
      code: 'OC',
      ticketStatus: 'Sold Out',
    ),
    CategoryItem(
      title: 'Web Development',
      imagePath: Assets.cryptoImg,
      startDate: DateTime(2025, 4, 5),
      code: 'WD',
      ticketStatus: '2 Tickets Available',
    ),
    CategoryItem(
      title: 'Data Science',
      imagePath: Assets.mindsetImg,
      startDate: DateTime(2025, 4, 5),
      code: 'DS',
      ticketStatus: 'Sold Out',
    ),
    CategoryItem(
      title: 'Machine Learning',
      imagePath: Assets.postImg,
      startDate: DateTime(2025, 4, 10),
      endDate: DateTime(2025, 4, 13),
      code: 'ML',
      ticketStatus: '7 Tickets Available',
    ),
    CategoryItem(
      title: 'Digital Marketing',
      imagePath: Assets.fitnessImg,
      startDate: DateTime(2025, 4, 12),
      endDate: DateTime(2025, 4, 13),
      code: 'DM',
      ticketStatus: '13 Tickets Available',
    ),
    CategoryItem(
      title: 'Graphic Design',
      imagePath: Assets.carousalImg,
      startDate: DateTime(2025, 4, 12),
      code: 'GD',
      ticketStatus: '4 Tickets Available',
    ),
    CategoryItem(
      title: 'Online Courses',
      imagePath: Assets.carousalImg,
      startDate: DateTime(2025, 4, 5),
      endDate: DateTime(2025, 4, 6),
      code: 'OC',
      ticketStatus: 'Sold Out',
    ),
    CategoryItem(
      title: 'Web Development',
      imagePath: Assets.cryptoImg,
      startDate: DateTime(2025, 4, 5),
      code: 'WD',
      ticketStatus: '2 Tickets Available',
    ),
    CategoryItem(
      title: 'Data Science',
      imagePath: Assets.mindsetImg,
      startDate: DateTime(2025, 4, 5),
      code: 'DS',
      ticketStatus: 'Sold Out',
    ),
    CategoryItem(
      title: 'Machine Learning',
      imagePath: Assets.postImg,
      startDate: DateTime(2025, 4, 10),
      endDate: DateTime(2025, 4, 13),
      code: 'ML',
      ticketStatus: '7 Tickets Available',
    ),
  ];

  SubjectScreen({super.key});

  final TextEditingController searchController = TextEditingController();

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
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: "Subjects",
          onLeadingPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          children: [
            Divider(color: ThemeColors.borderColor(context), height: 0.5.h),
            20.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: customSearchWidget(
                "Search for Subjects",
                searchController,
                context,
              ),
            ),
            16.heightBox,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(category: category);
                  },
                ),
              ),
            ),
            16.heightBox,
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryItem category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            category.imagePath,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.4),
            colorBlendMode: BlendMode.darken,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "4-04-2025",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        color: ThemeColors.subjTextColor(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        category.code,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: AppFonts.inter,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: AppFonts.inter,
                    color: ThemeColors.subjTextColor(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              5.heightBox,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ThemeColors.subjCardColor(context),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BUY TICKETS',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: AppFonts.inter,
                          color: ThemeColors.subjTextColor(context),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        category.ticketStatus,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: AppFonts.inter,
                          color: ThemeColors.subjTextColor(context),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
