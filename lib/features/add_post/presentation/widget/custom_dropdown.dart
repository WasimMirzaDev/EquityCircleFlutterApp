import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final List<String> items;

  const CustomDropdown({
    super.key,
    required this.controller,
    required this.hint,
    required this.items,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value:
          widget.items.contains(widget.controller.text)
              ? widget.controller.text
              : null,
      decoration: InputDecoration(
        hintText: widget.hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      items:
          widget.items.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      onChanged: (newValue) {
        setState(() {
          widget.controller.text = newValue!;
        });
      },
    );
  }
}
