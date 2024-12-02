import 'package:flutter/material.dart';

class DropDownInputPopup extends StatefulWidget {
  final List selectItems;
  final String labelText;
  final ValueChanged<String> onChanged;

  const DropDownInputPopup({
    super.key,
    required this.selectItems,
    this.labelText = "Select",
    required this.onChanged,
  });

  @override
  State<DropDownInputPopup> createState() => _DropDownInputPopupState();
}

class _DropDownInputPopupState extends State<DropDownInputPopup> {
  String? genderValue;

  @override
  void initState() {
    super.initState();
    if (widget.selectItems.isNotEmpty) {
      genderValue = widget.selectItems[0]['id'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      value: genderValue,
      dropdownColor: Colors.white,
      onChanged: (newValue) {
        if (newValue != null) {
          setState(() {
            genderValue = newValue.toString();
          });
          widget.onChanged(newValue.toString()); // Pass selected value to the callback
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
      value == null ? 'Please select ${widget.labelText}' : null,
      items: widget.selectItems.map((value) {
        return DropdownMenuItem(
          value: value['id'],
          child: Text(
            value['name'],
            style: TextStyle(color: Color(int.parse(value['color_code']))),
          ),
        );
      }).toList(),
    );
  }
}
