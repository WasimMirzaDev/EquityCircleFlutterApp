import 'package:equitycircle/core/constants/constants.dart'
    show PAGE_MARGIN_HOR;
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomQuillEditor extends StatefulWidget {
  final quill.QuillController controller;
  final Color backgroundColor;

  const CustomQuillEditor({
    super.key,
    required this.controller,
    required this.backgroundColor,
  });

  @override
  _CustomQuillEditorState createState() => _CustomQuillEditorState();
}

class _CustomQuillEditorState extends State<CustomQuillEditor> {
  bool _isPlaceholderVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.document = quill.Document()..insert(0, "Write here...");
    widget.controller.changes.listen((event) {
      final text = widget.controller.document.toPlainText().trim();

      if (_isPlaceholderVisible && text == "Write here...") {
        Future.delayed(Duration(milliseconds: 100), () {
          widget.controller.document = quill.Document();
          setState(() => _isPlaceholderVisible = false);
        });
      } else if (!_isPlaceholderVisible && text.isEmpty) {
        Future.delayed(Duration(milliseconds: 100), () {
          widget.controller.document =
              quill.Document()..insert(0, "Write here...");
          setState(() => _isPlaceholderVisible = true);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        quill.QuillSimpleToolbar(
          controller: widget.controller,
          config: quill.QuillSimpleToolbarConfig(
            toolbarIconAlignment: WrapAlignment.start,
            toolbarSize: 5,

            toolbarRunSpacing: 0,
            showHeaderStyle: true,
            showBoldButton: true,
            showItalicButton: true,
            showUnderLineButton: true,
            showLink: true,
            showCenterAlignment: true,
            showListBullets: true,
            showSubscript: true,
            showClearFormat: false,
            showStrikeThrough: false,
            showInlineCode: false,
            showColorButton: false,
            showBackgroundColorButton: false,
            showListNumbers: false,
            showListCheck: false,
            showQuote: false,
            showIndent: false,
            showUndo: false,
            showRedo: false,
            showSearchButton: false,
            showSuperscript: false,
          ),
        ),
        Container(
          height: 120.h,
          decoration: BoxDecoration(color: widget.backgroundColor),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: PAGE_MARGIN_HOR,
              vertical: 8.h,
            ),
            child: quill.QuillEditor.basic(controller: widget.controller),
          ),
        ),
      ],
    );
  }
}
