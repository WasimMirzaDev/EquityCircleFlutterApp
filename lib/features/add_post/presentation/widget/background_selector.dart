import 'package:equitycircle/core/models/feeds_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill show QuillController;
import 'package:image_picker/image_picker.dart';

class CreatePostController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final quill.QuillController quillController = quill.QuillController.basic();
  String selectedPrivacy = "Public";
  String selectedCategory = "Business";
  bool isEditing = false;
  List<String> attachments = [];
  Color selectedBackground = Colors.white;
  final List<Color> backgrounds = [
    Colors.white,
    Color(0xFFFFF0D6),
    Color(0xFFE0C3FC),
    Color(0xFFB2EBF2),
    Color(0xFFF8BBD0),
  ];

  void initPost(DataByFeed? post) {
    if (post?.id != null) {
      isEditing = true;
      titleController.text = post!.title ?? "";
      descriptionController.text = post.description ?? "";
      selectedPrivacy = post.visibility?.trim() ?? "Public";
      selectedCategory = _mapCategoryIdToName(post.categoryId);
    }
  }

  Future<void> pickAttachment({bool isVideo = false}) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile =
        isVideo
            ? await picker.pickVideo(source: ImageSource.gallery)
            : await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      attachments.add(pickedFile.path);
    }
  }

  void removeAttachment(int index) {
    attachments.removeAt(index);
  }

  void selectBackgroundColor(Color color) {
    selectedBackground = color;
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
        return "";
    }
  }
}
