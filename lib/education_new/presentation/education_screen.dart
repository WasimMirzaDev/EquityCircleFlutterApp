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

import '../../core/constants/theme_colors.dart';

class NewEducationScreen extends StatelessWidget {
  final List<CategoryItem> categories = [
    CategoryItem('Online Courses', Assets.carousalImg),
    CategoryItem('Web Development', Assets.cryptoImg),
    CategoryItem('Data Science', Assets.mindsetImg),
    CategoryItem('Machine Learning', Assets.postImg),
    CategoryItem('Digital Marketing', Assets.fitnessImg),
    CategoryItem('Graphic Design', Assets.carousalImg),

    CategoryItem('Photography', Assets.cryptoImg),
    CategoryItem('Language Learning', Assets.mindsetImg),
    CategoryItem('Business Management', Assets.postImg),
    CategoryItem('UX/UI Design', Assets.fitnessImg),
    CategoryItem('Artificial Intelligence', Assets.carousalImg),
  ];

  NewEducationScreen({super.key});
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
          title: "Education",
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
                "Search for education",
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
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/SubjectScreen');
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

class CategoryItem {
  final String title;
  final String imagePath;

  CategoryItem(this.title, this.imagePath);
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
          Image.asset(category.imagePath, fit: BoxFit.cover),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 30.h,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(
                  category.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: AppFonts.inter,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
