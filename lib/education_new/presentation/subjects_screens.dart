import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_appbar.dart' show CustomAppBar;
import 'package:equitycircle/features/bussiness/presentation/widgets/custom_search_field.dart'
    show customSearchWidget;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
      title: 'Combat Gyms',
      imagePath: Assets.gym3,
      startDate: DateTime(2025, 4, 12),
      endDate: DateTime(2025, 4, 13),
      code: 'DM',
      ticketStatus: '13 Tickets Available',
    ),
    CategoryItem(
      title: 'Commercial Gym',
      imagePath: Assets.gym,
      startDate: DateTime(2025, 4, 5),
      endDate: DateTime(2025, 4, 6),
      code: 'OC',
      ticketStatus: 'Sold Out',
    ),
    CategoryItem(
      title: 'CrossFit Boxes',
      imagePath: Assets.crypto,
      startDate: DateTime(2025, 4, 5),
      code: 'WD',
      ticketStatus: '2 Tickets Available',
    ),
    CategoryItem(
      title: 'Home Gyms',
      imagePath: Assets.education3,
      startDate: DateTime(2025, 4, 12),
      endDate: DateTime(2025, 4, 13),
      code: 'DM',
      ticketStatus: '13 Tickets Available',
    ),
    CategoryItem(
      title: 'Powerlifting Gyms',
      imagePath: Assets.educationImg,
      startDate: DateTime(2025, 4, 5),
      code: 'DS',
      ticketStatus: 'Sold Out',
    ),
    CategoryItem(
      title: 'Bodybuidng Gyms ',
      imagePath: Assets.mindset,
      startDate: DateTime(2025, 4, 10),
      endDate: DateTime(2025, 4, 13),
      code: 'ML',
      ticketStatus: '7 Tickets Available',
    ),
    CategoryItem(
      title: 'Home Gyms',
      imagePath: Assets.sport,
      startDate: DateTime(2025, 4, 12),
      endDate: DateTime(2025, 4, 13),
      code: 'DM',
      ticketStatus: '13 Tickets Available',
    ),
    CategoryItem(
      title: 'Combat Gyms',
      imagePath: Assets.gym2,
      startDate: DateTime(2025, 4, 12),
      endDate: DateTime(2025, 4, 13),
      code: 'DM',
      ticketStatus: '13 Tickets Available',
    ),
    CategoryItem(
      title: 'Bodybuidng Gyms ',
      imagePath: Assets.education2,
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
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/CorporateFinanceScreen');
                      },

                      child: CategoryCard(category: category),
                    );
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.lightGreyColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Background image
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
                child: Image.asset(
                  category.imagePath,
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: double.infinity,
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        category.title,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(color: ThemeColors.cardColor(context)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  5.heightBox,
                  Text(
                    'Available Seats: 5',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontFamily: AppFonts.inter,
                      color: ThemeColors.textColor(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Duration: ${category.formattedDate}',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 10.sp,
                      overflow: TextOverflow.ellipsis,
                      fontFamily: AppFonts.inter,
                      color: ThemeColors.textColor(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
