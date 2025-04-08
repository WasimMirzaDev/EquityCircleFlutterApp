import 'dart:io';

import 'package:equitycircle/core/constants/appColors.dart' show AppColors;
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/providers/feeds_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/theme_colors.dart';
import '../../../core/widgets/loading_indicator.dart';

class CommentInputBar extends StatefulWidget {
  final int feedId;
  final int categoryId;
  const CommentInputBar({
    super.key,
    required this.feedId,
    required this.categoryId,
  });

  @override
  State<CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<CommentInputBar> {
  final TextEditingController textController = TextEditingController();
  File? selectedFile;
  void _handleComment() {
    final String comment = textController.text.trim();
    if (comment.isNotEmpty) {
      final int feedId = widget.feedId;

      final FeedsProvider feedsProvider = Provider.of<FeedsProvider>(
        context,
        listen: false,
      );

      feedsProvider.postComment(feedId, comment, context, widget.categoryId);
      textController.clear();
    }
  }

  Future<void> _pickMedia() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        selectedFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _openCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        selectedFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 36.h,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: ThemeColors.commentBgColor(context),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: "Write a comment",
                      border: InputBorder.none,
                      fillColor: ThemeColors.commentBgColor(context),
                      hintStyle: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.commenttextColor(context),
                      ),
                      isDense: true,
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: _pickMedia,

                  child: SvgPicture.asset(
                    Assets.mediaIcon,
                    color: ThemeColors.commentfielIconsColor(context),
                  ),
                ),
                10.widthBox,
                GestureDetector(
                  onTap: _pickImage,
                  child: SvgPicture.asset(
                    Assets.imageicon,
                    color: ThemeColors.commentfielIconsColor(context),
                  ),
                ),
                10.widthBox,
                GestureDetector(
                  onTap: _openCamera,
                  child: SvgPicture.asset(
                    Assets.camera,
                    color: ThemeColors.commentfielIconsColor(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        8.widthBox,
        GestureDetector(
          onTap: () {
            _handleComment();
          },
          child:
              Provider.of<FeedsProvider>(
                    context,
                  ).isLoadingComment(widget.feedId)
                  ? LoadingIndicator(
                    radius: 10.r,
                    activeColor: AppColors.purpleColor,
                    inactiveColor: AppColors.greyColor,
                    animationDuration: Duration(milliseconds: 500),
                  )
                  : Container(
                    height: 36.h,
                    width: 36.w,
                    decoration: BoxDecoration(
                      color: ThemeColors.sendBgColor(context),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.sendicon,
                        color: ThemeColors.sendIconColor(context),
                      ),
                    ),
                  ),
        ),
      ],
    );
  }
}
