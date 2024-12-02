import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components_list.dart'
    show
        BuildContext,
        Colors,
        Column,
        Get,
        Icon,
        Icons,
        MainAxisAlignment,
        Offset,
        PopupMenuItem,
        RelativeRect,
        RenderBox,
        State,
        StatefulWidget,
        Text,
        Widget,
        kDebugMode,
        showMenu;

class DropdownMoreIcon extends StatefulWidget {
  final String taskId;

  const DropdownMoreIcon({super.key, required this.taskId});

  @override
  _DropdownMoreIconState createState() => _DropdownMoreIconState();
}

class _DropdownMoreIconState extends State<DropdownMoreIcon> {
  String? selectedValue;
  final List<String> options = ['Edit', 'View'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: const Icon(Icons.more_horiz),
          onTap: () {
            _showDropdownMenu(context);
          },
        ),
        if (selectedValue != null) const Text(''),
      ],
    );
  }

  void _showDropdownMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset buttonPosition = button.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      color: Colors.white,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx,
        buttonPosition.dy + button.size.height,
        0,
        0,
      ),
      items: options.map((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      elevation: 8, // Optional: Add shadow for better visibility
    ).then((value) {
      if (value != null) {
        _handleDropdownSelection(value);
      }
    });
  }

  void _handleDropdownSelection(String value) {
    setState(() {
      selectedValue = value;
    });

    if (kDebugMode) {
      print("Selected: $selectedValue");
    }
    if (kDebugMode) {
      print("Task ID: ${widget.taskId}");
    }

    if (value == 'Edit') {
      Get.toNamed('addComment', arguments: {'taskId': widget.taskId});
    } else if (value == 'View') {
      Get.toNamed('taskDetails', arguments: {'taskId': widget.taskId});
    }
  }
}
