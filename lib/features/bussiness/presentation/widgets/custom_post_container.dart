import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/models/feeds_model.dart';
import 'package:equitycircle/features/add_post/presentation/create_post_screen.dart';
import 'package:equitycircle/features/feeds/widgets/comment_InputBar.dart'
    show CommentInputBar;
import 'package:equitycircle/features/feeds/widgets/media_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:html/parser.dart' as htmlParser;
import 'package:provider/provider.dart';

import '../../../../core/providers/feeds_provider.dart';

Widget customPostContainer(
  DataByFeed post,
  int feedId,
  int categoryId,
  String profileUrl,
  String name,
  String date,
  String discription,
  VoidCallback commentTap,
  VoidCallback favTap,
  String tab,
  Color tabBgColor,
  Color tabTextColor,
  List<MediaByFeeds> media,
  BuildContext context,
  List<dynamic> likes,
  bool isLiked,
  List<dynamic> comments,
  bool isAdmin,
) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: AppColors.white,
      border: Border.all(color: AppColors.lightGreyColor),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(profileUrl)),
                  10.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              if (isAdmin)
                PopupMenuButton<String>(
                  icon: SvgPicture.asset(Assets.moreHorizontal),
                  onSelected: (value) {
                    print("PopupMenu selected: $value"); // Debugging print

                    if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreatePostScreen(post: post),
                        ),
                      );
                    } else if (value == 'delete') {
                      print(
                        "Delete button clicked for feedId: $feedId",
                      ); // Debugging print

                      final feedsProvider = Provider.of<FeedsProvider>(
                        context,
                        listen: false,
                      );
                      feedsProvider.deletePost(feedId, context);
                    }
                  },
                  itemBuilder:
                      (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: AppColors.black,
                                size: 18,
                              ),
                              10.widthBox,
                              Text("Edit", style: TextStyle(fontSize: 14.sp)),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 18),
                              10.widthBox,
                              Text(
                                "Delete",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                ),
            ],
          ),
          20.heightBox,

          Row(
            children: [
              Container(
                // height: 30.h,
                decoration: BoxDecoration(
                  color: tabBgColor,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  child: Center(
                    child: Text(
                      tab,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: tabTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          8.heightBox,
          Text(
            htmlParser.parse(discription).body?.text ?? '',
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: AppFonts.inter,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),

          12.heightBox,
          if (media.isNotEmpty) MediaGrid(media: media),
          12.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commentsFavRow(
                  context,

                  favTap,
                  likes.length.toString(),
                  SvgPicture.asset(
                    isLiked ? Assets.heartFilled : Assets.heartunFilled,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
                commentsFavRow(
                  context,
                  commentTap,
                  comments.length.toString(),
                  SvgPicture.asset(Assets.commentIcon),
                ),
                commentsFavRow(
                  context,

                  () {},
                  "0",
                  SvgPicture.asset(Assets.reposticon),
                ),
              ],
            ),
          ),
          12.heightBox,

          CommentInputBar(feedId: feedId, categoryId: categoryId),
        ],
      ),
    ),
  );
}

Widget commentsFavRow(
  BuildContext context,

  VoidCallback onTap,
  String length,

  Widget img,
) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        img,
        5.widthBox,
        Text(
          length,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: AppFonts.inter,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ],
    ),
  );
}
