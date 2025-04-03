import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/features/job_application/widgets/job_application_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../job_list/job_detail_screen.dart';

class JobApplicationScreen extends StatefulWidget {
  const JobApplicationScreen({super.key});

  @override
  State<JobApplicationScreen> createState() => _JobApplicationScreenState();
}

class _JobApplicationScreenState extends State<JobApplicationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    PendingTab(),
    Center(child: Text('Rejected Applications')),
    Center(child: Text('Accepted Applications')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.offWhite,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: Text(
          "Job Applications",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.inter,
            fontSize: 14.sp,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(Assets.backArrow, height: 20.h),
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.canPop()) {
                context.pop(); // 🔄 Goes back safely
              } else {
                context.go('/'); // 🏠 Fallback if no previous page
              }
            });
          },
        ),
      ),
      body: Column(
        children: [
          Divider(color: AppColors.lightGreyColor, height: 0.5.h),
          20.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTabButton(0, 'Pending'),
                _buildTabButton(1, 'Rejected'),
                _buildTabButton(2, 'Accepted'),
              ],
            ),
          ),
          20.heightBox,
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: Container(
          height: 25.h,
          width: 75.w,
          decoration: BoxDecoration(
            color:
                _selectedIndex == index
                    ? AppColors.purpleColor
                    : AppColors.transparent,
            borderRadius: BorderRadius.circular(4.r),
            border:
                _selectedIndex == index
                    ? null
                    : Border.all(color: AppColors.darkGrey),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color:
                  _selectedIndex == index
                      ? AppColors.white
                      : AppColors.darkGrey,
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              fontFamily: AppFonts.inter,
            ),
          ),
        ),
      ),
    );
  }
}

class PendingTab extends StatelessWidget {
  const PendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => JobDetailScreen(
                        title: "Sales and Growth Executive",

                        image: "",
                        discription: "Sales and Growth Executive",
                      ),
                ),
              );
            },
            child: JobApplicationCardWidget(
              status: "Pending",
              title: "Sales and Growth Executive",
              statucBGColor: AppColors.lightYellow,
              statucTextColor: AppColors.yellow,
              applicateName: "Admin",
              appliedDate: "2/27/2025",
            ),
          ),
        );
      },
    );
  }
}
