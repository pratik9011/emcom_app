import 'components_list.dart'
    show
        BuildContext,
        Colors,
        DropdownButton,
        DropdownMenuItem,
        Icon,
        Icons,
        State,
        StatefulWidget,
        Text,
        Widget;

class DropDownFilterIcon extends StatefulWidget {
  final List<Map<String, String>> selectItems;
  final String labelText;

  const DropDownFilterIcon(
      {super.key, required this.selectItems, this.labelText = "Select"});

  @override
  _DropDownFilterIconState createState() => _DropDownFilterIconState();
}

class _DropDownFilterIconState extends State<DropDownFilterIcon> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: const Icon(Icons.filter_alt_outlined, color: Colors.blue, size: 20),
      value: selectedValue,
      dropdownColor: Colors.white,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
      items: widget.selectItems
          .map<DropdownMenuItem<String>>((Map<String, String> item) {
        return DropdownMenuItem<String>(
          value: item['id'],
          child: Text(item['name']!),
        );
      }).toList(),
    );
  }
}
