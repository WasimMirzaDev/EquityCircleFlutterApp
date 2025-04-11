import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/models/feeds_model.dart';
import 'package:equitycircle/core/providers/feeds_provider.dart';
import 'package:equitycircle/core/widgets/custom_appbar.dart' show CustomAppBar;
import 'package:equitycircle/core/widgets/custom_button.dart';
import 'package:equitycircle/core/widgets/custom_snackbar.dart';
import 'package:equitycircle/core/widgets/loading_indicator.dart';
import 'package:equitycircle/features/feeds/helpers/picture_helpers.dart';
import 'package:flex_color_picker/flex_color_picker.dart' show ColorPicker;
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart' show Provider;

import '../../../core/constants/theme_colors.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/widgets/custom_textfield.dart';
import 'widget/discard_dialogbox.dart';

class CreatePostScreen extends StatefulWidget {
  final DataByFeed? post;

  const CreatePostScreen({super.key, this.post});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String selectedPrivacy = "Public";
  String selectedCategory = "Business";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
  final quill.QuillController _controller = quill.QuillController.basic();
  List<String> attachments = []; // Store attachment paths

  // final List<File> _selectedImages = [];
  // final List<File> _selectedVideos = [];
  bool _isEditing = false;
  Future<void> _pickAttachment({bool isVideo = false}) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile;

    if (isVideo) {
      // Pick a video file
      pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    } else {
      // Pick an image file
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      setState(() {
        attachments.add(pickedFile?.path ?? "");
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  late Color _selectedBackground;
  final List<Color> _backgrounds = [
    Colors.white,
    Color(0xFFFFF0D6),
    Color(0xFFE0C3FC),
    Color(0xFFB2EBF2),
    Color(0xFFF8BBD0),
  ];
  @override
  void initState() {
    super.initState();

    if (widget.post?.id != null) {
      _isEditing = true;
      titleController.text = widget.post!.title ?? "";
      discriptionController.text = widget.post!.description ?? "";

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          selectedPrivacy =
              widget.post!.visibility?.trim() ??
              "Public"; // Trim to avoid spaces
          selectedCategory = _mapCategoryIdToName(widget.post!.categoryId);

          // _controller = quill.QuillController(
          //   document: quill.Document.fromDelta(
          //     quill.Delta()..insert("${widget.post!.description}\n"),
          //   ),
          //   selection: const TextSelection.collapsed(offset: 0),
          // );
        });

        debugPrint("Selected Privacy: $selectedPrivacy");
      });
    }
  }

  String _mapCategoryIdToName(int? categoryId) {
    switch (categoryId) {
      case 1:
        return "Business";
      case 2:
        return "Fitness";
      case 3:
        return "Crypto";
      case 5:
        return "Mindset";
      default:
        return ""; // Handle unexpected values
    }
  }

  void _pickColor(BuildContext context) {
    Color pickedColor = _selectedBackground;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text('Pick a Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              // pickerColor: pickedColor,
              onColorChanged: (color) {
                pickedColor = color;
              },
              // showLabel: true,
              // pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Select'),
              onPressed: () {
                setState(() {
                  _selectedBackground = pickedColor;
                  _backgrounds.add(pickedColor); // Add custom color to list
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildBackgroundSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ..._backgrounds.map((color) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedBackground = color;
              });
            },
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.lightGreyColor),
              ),
            ),
          );
        }),
        GestureDetector(
          onTap: () => _pickColor(context),
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.lightGreyColor),
            ),
            child: Icon(Icons.color_lens, color: AppColors.darkGrey),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // final feedsProvider = Provider.of<FeedsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    _selectedBackground = ThemeColors.search(context);
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
          title: _isEditing ? "Edit Post" : "Create Post",
          onLeadingPressed: () {
            showDiscardDialog(
              context,
              "Discard Changes?",
              "Are you sure you want to discard your changes? All unsaved modifications will be lost.",
              "Cancel",
              "Discard",
              () => Navigator.pop(context, true),
              () {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
              },
            );
          },
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: AppColors.lightGreyColor, height: 0.5.h),

              10.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          getProfileImageUrl(authProvider.userData),
                        ),
                      ),
                    ),
                    10.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        16.heightBox,
                        Text(
                          widget.post?.user?.name ?? "Admin",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: AppFonts.inter,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.textColor(context),
                          ),
                        ),
                        Text(
                          widget.post?.user?.roles ?? "Admin",
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
              ),

              20.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
                child: _buildPrivacySelector(),
              ),
              16.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(
                    //   ".",
                    //   style: TextStyle(
                    //     fontSize: 30.sp,
                    //     fontFamily: AppFonts.inter,
                    //     color: AppColors.darkGrey,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    Text(
                      "• ",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    Text(
                      "Anyone can see your post",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
              16.heightBox,
              Divider(color: AppColors.lightGreyColor, height: 1.h),
              16.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Category*",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    16.heightBox,
                    _buildCategorySelector(),
                    16.heightBox,
                    Text(
                      "Title*",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: titleController,
                      hint: "Enter title*",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,
                    Text(
                      "Description*",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    CustomTextField(
                      controller: discriptionController,
                      hint: "Write here...",
                      maxLines: 4,
                      fillColor: _selectedBackground,
                    ),

                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: AppColors.white,
                    //     border: Border.all(
                    //       color: AppColors.lightGreyColor,
                    //       width: 0.5,
                    //     ),
                    //     borderRadius: BorderRadius.circular(8.r),
                    //   ),
                    //   child: CustomQuillEditor(
                    //     controller: _controller,
                    //     backgroundColor: _selectedBackground,
                    //   ),
                    // ),
                    16.heightBox,
                    Text(
                      "Select Background",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    _buildBackgroundSelector(),

                    16.heightBox,
                    Text(
                      "Attachments",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors.textColor(context),
                      ),
                    ),
                    8.heightBox,
                    _buildAttachments(),
                    35.heightBox,

                    CustomButton(
                      text: _isEditing ? "Update Post" : "Post",
                      onTap: () async {
                        if (titleController.text.isEmpty ||
                            discriptionController.text.isEmpty ||
                            selectedCategory.isEmpty ||
                            selectedPrivacy.isEmpty) {
                          showTopSnackbar(
                            context,
                            "Title, Description, Category, and Privacy is required.",
                            true,
                          );

                          return;
                        }

                        Map<String, String> categoryIds = {
                          "Business": "1",
                          "Fitness": "2",
                          "Crypto": "3",
                          "Mindset": "5",
                        };

                        String? categoryId = categoryIds[selectedCategory];

                        if (categoryId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invalid category selection."),
                            ),
                          );
                          return;
                        }

                        final feedsProvider = Provider.of<FeedsProvider>(
                          context,
                          listen: false,
                        );

                        // Convert attachment paths to File objects
                        List<File> imageFiles =
                            attachments.map((path) => File(path)).toList();

                        // Show loading indicator
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder:
                              (context) => Center(
                                child: LoadingIndicator(
                                  radius: 15,
                                  activeColor: ThemeColors.indicatorColor(
                                    context,
                                  ),
                                  inactiveColor: AppColors.greyColor,
                                  animationDuration: Duration(
                                    milliseconds: 500,
                                  ),
                                ),
                              ),
                        );

                        try {
                          if (_isEditing) {
                            final response = await feedsProvider.editPost(
                              context,
                              widget.post?.id.toString() ?? "",
                              titleController.text,
                              discriptionController.text,
                              categoryId,

                              selectedPrivacy,
                              imageFiles,
                              [],
                            );

                            Navigator.pop(context); // Close loading dialog

                            if (response != null) {
                              // Navigate back or show success message
                              Navigator.pop(context, true);
                              showTopSnackbar(
                                context,
                                "Post created successfully!",
                                true,
                              );
                            } else {
                              print("eidt post id ${widget.post?.id}");
                              showTopSnackbar(
                                context,
                                "Failed to create post",
                                false,
                              );
                            }
                          } else {
                            final response = await feedsProvider.createPost(
                              context,
                              titleController.text,
                              discriptionController.text,
                              categoryId, // Pass category ID instead of the name

                              selectedPrivacy,
                              imageFiles,
                              [],
                            );

                            Navigator.pop(context); // Close loading dialog

                            if (response != null) {
                              // Navigate back or show success message
                              Navigator.pop(context, true);
                              showTopSnackbar(
                                context,
                                "Post created successfully!",
                                true,
                              );
                            } else {
                              showTopSnackbar(
                                context,
                                "Failed to create post",
                                false,
                              );
                            }
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          showTopSnackbar(
                            context,
                            "Error: ${e.toString()}",
                            false,
                          );
                        }
                      },
                    ),
                    24.heightBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachments() {
    return Wrap(
      spacing: 10,

      children: [
        _attachmentBox(Assets.pauseiCON, "video"),
        // _attachmentBox(Assets.photoIcon, "photo"),
        ...attachments.map((path) => _attachmentPreview(path)),
        _addAttachmentBox(),
      ],
    );
  }

  Widget _attachmentBox(String icon, String type) {
    return GestureDetector(
      onTap: () {
        if (type == "video") {
          _pickAttachment(isVideo: true);
        } else if (type == "photo") {
          _pickAttachment();
        }
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8.r),
        strokeWidth: 0.5,
        dashPattern: [6, 4],
        color: ThemeColors.dottedColor(context),
        child: Container(
          width: 66.w,
          height: 66.h,
          decoration: BoxDecoration(
            color: ThemeColors.attachmentContainerColor(context),

            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              height: 18.h,
              width: 18.w,
              color: ThemeColors.dottedColor(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _attachmentPreview(String path) {
    return Stack(
      children: [
        Container(
          width: 66.w,
          height: 66.h,
          decoration: BoxDecoration(
            color: ThemeColors.attachmentContainerColor(context),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, color: Colors.red);
              },
            ),
          ),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: GestureDetector(
            onTap: () => _removeAttachment(attachments.indexOf(path)),
            child: Icon(Icons.cancel, size: 16, color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _addAttachmentBox() {
    return GestureDetector(
      onTap: _pickAttachment,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8.r),
        strokeWidth: 0.5,
        dashPattern: [6, 4],
        color: ThemeColors.dottedColor(context),
        child: Container(
          width: 66.w,
          height: 66.h,
          decoration: BoxDecoration(
            color: ThemeColors.attachmentContainerColor(context),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              Assets.photoIcon,
              height: 18.h,
              width: 18.w,
              color: ThemeColors.dottedColor(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _privacyButton("Public", Assets.publicIcon),
          _privacyButton("Private", Assets.privateIcon),
          _privacyButton("Password", Assets.lock),
        ],
      ),
    );
  }

  Widget _privacyButton(String label, String icon) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedPrivacy = label);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Container(
          width: 113.w,
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border:
                selectedPrivacy.toLowerCase() == label.toLowerCase()
                    ? null
                    : Border.all(color: ThemeColors.borderColor(context)),

            gradient:
                Theme.of(context).brightness == Brightness.dark &&
                        selectedPrivacy.toLowerCase() == label.toLowerCase()
                    ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x80FFFFFF), // 50% opacity
                        Color(0x1AFFFFFF),
                      ],
                    )
                    : null,

            color:
                selectedPrivacy.toLowerCase() == label.toLowerCase()
                    ? Theme.of(context).brightness == Brightness.dark
                        ? null
                        : AppColors.purpleColor
                    : ThemeColors.postCatagoriesBox(context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                color:
                    selectedPrivacy.toLowerCase() == label.toLowerCase()
                        ? AppColors.white
                        : ThemeColors.iconColor(context),
              ),
              5.widthBox,
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w400,
                  color:
                      selectedPrivacy.toLowerCase() == label.toLowerCase()
                          ? AppColors.white
                          : ThemeColors.textColor(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            ["Business", "Fitness", "Crypto", "Mindset"].map((category) {
              return _categoryButton(category);
            }).toList(),
      ),
    );
  }

  Widget _categoryButton(String category) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedCategory = category);
      },

      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Container(
          width: 82.w,
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border:
                selectedCategory == category
                    ? null
                    : Border.all(color: ThemeColors.borderColor(context)),

            gradient:
                Theme.of(context).brightness == Brightness.dark &&
                        selectedCategory == category
                    ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x80FFFFFF), // 50% opacity
                        Color(0x1AFFFFFF),
                      ],
                    )
                    : null,

            color:
                selectedCategory == category
                    ? Theme.of(context).brightness == Brightness.dark
                        ? null
                        : AppColors.purpleColor
                    : ThemeColors.postCatagoriesBox(context),
          ),

          child: Center(
            child: Text(
              category,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: AppFonts.inter,
                fontWeight: FontWeight.w400,
                color:
                    selectedCategory == category
                        ? AppColors.white
                        : ThemeColors.textColor(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
