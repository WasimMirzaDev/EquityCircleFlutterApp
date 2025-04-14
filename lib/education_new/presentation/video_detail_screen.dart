import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../core/constants/appColors.dart';
import '../../core/constants/theme_colors.dart';
import '../../core/widgets/custom_appbar.dart';

class VideoDetailScreen extends StatefulWidget {
  const VideoDetailScreen({super.key});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      )
      ..initialize().then((_) {
        setState(() {});
      });
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
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
          title: "Video Detail",
          onLeadingPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          children: [
            Divider(color: ThemeColors.borderColor(context), thickness: 0.5.h),

            20.heightBox,
            _controller.value.isInitialized
                ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_controller),
                      IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: AppColors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                      ),
                    ],
                  ),
                )
                : Container(
                  height: 200,
                  color: Colors.grey[900],
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
            Container(
              padding: const EdgeInsets.all(12),
              color: ThemeColors.background(context),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Unlocking the drivers of value",

                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.textColor(context),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Capital Investment",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors.subTextColor(context),
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,

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
              tabs: const [
                Tab(text: 'Transcript'),
                Tab(text: 'Notes'),
                Tab(text: 'Summary'),
                Tab(text: 'Attachments'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _transcriptTab(),
                  Center(
                    child: Text(
                      'No notes yet',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Summary coming soon',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'No attachments available',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _bottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _transcriptTab() {
    final transcript = [
      [
        "0:00",
        "Let’s take a closer look at what drives value for a business...",
      ],
      ["0:27", "So to the extent a company has a better strategy..."],
      ["0:49", "On the denominator when we look at cost of capital..."],
      ["1:05", "And then on the other side of the denominator, of course..."],
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: transcript.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: RichText(
            text: TextSpan(
              text: '${transcript[index][0]} ',

              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: AppFonts.inter,
                fontWeight: FontWeight.w400,
                color: ThemeColors.textColor(context),
              ),

              children: [
                TextSpan(
                  text: transcript[index][1],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: AppFonts.inter,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors.textColor(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bottomButtons() {
    return Container(
      color: ThemeColors.background(context),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navButton(Icons.arrow_back, "Previous"),
            5.widthBox,
            _navButton(Icons.note_add, "Save a Note"),
            5.widthBox,
            _navButton(Icons.arrow_forward, "Next"),
            5.widthBox,
          ],
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, String label) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.background(context),
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white70),
      ),
      icon: Icon(icon, size: 16),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontFamily: AppFonts.inter,
          fontWeight: FontWeight.w400,
          color: ThemeColors.textColor(context),
        ),
      ),
      onPressed: () {},
    );
  }
}
