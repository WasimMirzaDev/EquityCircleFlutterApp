import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart' show Assets;
import 'package:equitycircle/core/constants/theme_colors.dart' show ThemeColors;
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/custom_appbar.dart';

class CorporateFinanceScreen extends StatefulWidget {
  const CorporateFinanceScreen({super.key});

  @override
  State<CorporateFinanceScreen> createState() => _CorporateFinanceScreenState();
}

class _CorporateFinanceScreenState extends State<CorporateFinanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final tabs = ['Dashboard', 'Grades', 'Forums', 'Notes', 'Resources'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildTabContent(int index) {
    return buildDashboardContent();
    // if (index == 0) return buildDashboardContent();
    // return Center(
    //   child: Text(
    //     "No data available",
    //     style: TextStyle(color: Colors.grey, fontSize: 18),
    //   ),
    // );
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
        backgroundColor: Colors.transparent,

        appBar: CustomAppBar(
          title: "Corporate Finance Fundamentals",
          onLeadingPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: ThemeColors.borderColor(context), thickness: 0.5.h),

            // 20.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TabBar(
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.zero,
                controller: _tabController,
                isScrollable: true,
                unselectedLabelStyle: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.textColor(context),
                ),
                labelStyle: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.textColor(context),
                ),
                indicatorColor: ThemeColors.textColor(context),
                labelColor: ThemeColors.textColor(context),
                unselectedLabelColor: ThemeColors.textColor(context),
                tabs: tabs.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
            10.heightBox,

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(
                  tabs.length,
                  (index) => buildTabContent(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDashboardContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView(
        children: [
          // Module Selector
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: List.generate(6, (index) {
          //     bool isSelected = index == 0;
          //     return CircleAvatar(
          //       backgroundColor:
          //           isSelected ? Colors.blue : Colors.grey.shade800,
          //       child: Text(
          //         '${index + 1}',
          //         style: TextStyle(
          //           color: isSelected ? Colors.white : Colors.grey,
          //         ),
          //       ),
          //     );
          //   }),
          // ),
          20.heightBox,

          // Reset Deadlines Card
          Container(
            decoration: BoxDecoration(
              color: ThemeColors.background(context),
              border: Border.all(color: AppColors.red, width: 0.8),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  Text(
                    "Don't let the great things you learned fade away! Reset your deadlines and complete your assignments every week.",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                      color: ThemeColors.textColor(context),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Reset My Deadlines'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      minimumSize: const Size.fromHeight(40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          20.heightBox,

          // Daily Goals
          Container(
            decoration: BoxDecoration(
              color: ThemeColors.background(context),
              border: Border.all(
                color: ThemeColors.borderColor(context),
                width: 0.8,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daily Goals",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.textColor(context),
                    ),
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      Icon(
                        Icons.check_box_outline_blank,
                        color: ThemeColors.iconColor(context),
                      ),
                      12.widthBox,
                      Expanded(
                        child: Text(
                          "Complete 3 lectures, readings, or quizzes",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: AppFonts.inter,
                            fontWeight: FontWeight.w500,
                            color: ThemeColors.textColor(context),
                          ),
                        ),
                      ),
                      Text(
                        "0 / 3",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.subTextColor(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          20.heightBox,

          // Getting Started
          Text(
            "Getting Started",
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: AppFonts.inter,
              fontWeight: FontWeight.w600,
              color: ThemeColors.textColor(context),
            ),
          ),
          10.heightBox,
          Text(
            "This introduction to corporate finance course will give an overview of all the key concepts you need for a high powered career in investment b...",
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: AppFonts.inter,
              fontWeight: FontWeight.w400,
              color: ThemeColors.subTextColor(context),
            ),
          ),
          20.heightBox,

          // Course Sections
          Row(
            children: [
              const Expanded(child: Divider(thickness: 1)),
              5.widthBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Introduction",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: AppFonts.inter,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.textColor(context),
                  ),
                ),
              ),
              5.widthBox,
              const Expanded(child: Divider(thickness: 1)),
            ],
          ),
          20.heightBox,

          GestureDetector(
            onTap: () {
              context.push('/VideoDetailScreen');
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ThemeColors.background(context),
                border: Border.all(
                  color: ThemeColors.borderColor(context),
                  width: 0.8,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Course Introduction",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w700,
                          color: ThemeColors.textColor(context),
                        ),
                      ),
                      12.heightBox,
                      Row(
                        children: [
                          _tag(
                            icon: Icons.check_circle,
                            label: "Video",
                            context: context,
                          ),
                          8.widthBox,
                          _tag(label: "1 min", context: context),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.check, color: ThemeColors.iconColor(context)),
                ],
              ),
            ),
          ),
          10.heightBox,
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ThemeColors.background(context),
              border: Border.all(
                color: ThemeColors.borderColor(context),
                width: 0.8,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Downloadable Files",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    12.heightBox,
                    Row(
                      children: [
                        _tag(
                          icon: Icons.check_circle,
                          label: "Reading",
                          context: context,
                        ),
                        8.widthBox,
                        _tag(label: "5 min", context: context),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.check, color: ThemeColors.iconColor(context)),
              ],
            ),
          ),
          20.heightBox,
        ],
      ),
    );
  }
}

Widget _tag({
  IconData? icon,
  required String label,
  required BuildContext context,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.green),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: AppColors.green, size: 16),
          4.widthBox,
        ],
        Text(
          label,
          style: TextStyle(
            color: ThemeColors.textColor(context),
            fontSize: 12.sp,
            fontFamily: AppFonts.inter,
          ),
        ),
      ],
    ),
  );
}
