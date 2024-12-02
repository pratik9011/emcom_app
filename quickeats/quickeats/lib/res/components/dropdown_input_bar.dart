import 'package:get/get.dart';

import 'components_list.dart'
    show
        AutovalidateMode,
        BorderRadius,
        BorderSide,
        BuildContext,
        Color,
        Colors,
        DropdownButtonFormField,
        DropdownMenuItem,
        EdgeInsets,
        Get,
        InputDecoration,
        OutlineInputBorder,
        State,
        StatefulWidget,
        TaskDetailsController,
        Text,
        TextStyle,
        Widget,
        kDebugMode;

class DropDownInput extends StatefulWidget {
  final List selectItems; // Required list of items
  final String labelText;

  const DropDownInput(
      {super.key, required this.selectItems, this.labelText = "Select"});

  @override
  State<DropDownInput> createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
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
    final data = Get.find<TaskDetailsController>();
    genderValue = data.data['status_id'] ?? genderValue;

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
      // value: genderValue,
      dropdownColor: Colors.white,
      onChanged: (newValue) {
        if (kDebugMode) {
          print(newValue);
        }
        data.statusCtr.text = newValue.toString();
        setState(() {
          genderValue = newValue.toString();
        });
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





