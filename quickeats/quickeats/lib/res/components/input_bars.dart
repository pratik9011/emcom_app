import 'components_list.dart'
    show
        AppColors,
        BorderRadius,
        Color,
        Column,
        CrossAxisAlignment,
        InputDecoration,
        OutlineInputBorder,
        Row,
        SizeConfig,
        SizedBox,
        TextEditingController,
        TextField,
        Widget,
        TextLine,
        translate;

Widget inputBar({
  required String labelText,
  required double heightFactor,
  required double widthFactor,
  double fontSize = 14,
  bool isEnabled = true,
  bool isRequired = false,
  Color textColor = AppColors.textColor,
  Color isRequiredColor = AppColors.red,
  bool isBold = true,
  required String? placeholder,
  TextEditingController? controllerName,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          TextLine(
            title: labelText,
            fontSize: fontSize,
            isBold: isBold,
            color: textColor,
          ),
          isRequired == true
              ? TextLine(
                  title: "*",
                  fontSize: fontSize,
                  isBold: isBold,
                  color: isRequiredColor)
              : const SizedBox(),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical = 10,
      ),
      SizedBox(
        width: SizeConfig.safeBlockHorizontal = widthFactor,
        height: SizeConfig.blockSizeVertical = heightFactor,
        child: TextField(
          controller: controllerName,
          maxLines: 8,
          decoration: InputDecoration(
            enabled: isEnabled,
            labelText: translate(placeholder!),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ],
  );
}
