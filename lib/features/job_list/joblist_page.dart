import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/providers/job_provider.dart';
import 'package:equitycircle/features/job_list/create_new_job.dart';
import 'package:equitycircle/features/job_list/widgets/job_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/theme_colors.dart';
import '../../core/widgets/loading_indicator.dart';
import 'job_detail_screen.dart';

class JoblistPage extends StatefulWidget {
  const JoblistPage({super.key});

  @override
  State<JoblistPage> createState() => _JoblistPageState();
}

class _JoblistPageState extends State<JoblistPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<JobProvider>(context, listen: false).getJobLists(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    return Scaffold(
      backgroundColor: ThemeColors.background(context),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        backgroundColor: ThemeColors.background(context),
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        title: Text(
          "Job listing",
          style: TextStyle(
            color: ThemeColors.textColor(context),
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.inter,
            fontSize: 14.sp,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.backArrow,
            height: 20.h,
            color: ThemeColors.iconColor(context),
          ),
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

      body:
          jobProvider.isLoading
              ? Center(
                child: LoadingIndicator(
                  radius: 15,
                  activeColor: ThemeColors.indicatorColor(context),
                  inactiveColor: AppColors.greyColor,
                  animationDuration: const Duration(milliseconds: 500),
                ),
              )
              : jobProvider.jobLists.isEmpty
              ? const Center(child: Text('No jobs available'))
              : Column(
                children: [
                  Divider(color: AppColors.lightGreyColor, height: 0.5.h),
                  20.heightBox,
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: jobProvider.jobLists.length,
                      itemBuilder: (context, index) {
                        final job = jobProvider.jobLists[index];
                        return Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => JobDetailScreen(
                                        title: job.title ?? "",
                                        image: job.mainImage ?? "",
                                        discription: job.description ?? "",
                                      ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: JobCardWidget(
                                // job: jobProvider.jobLists[index],
                                title: job.title ?? "",
                                image: job.mainImage ?? "",
                                discription: job.description ?? "",
                                readMore: true,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  20.heightBox,
                ],
              ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatNewJobScreen()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: AppColors.purpleColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                child: Row(
                  children: [
                    Icon(Icons.add, color: AppColors.white, size: 16.sp),
                    Text(
                      "Add new job",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.inter,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
