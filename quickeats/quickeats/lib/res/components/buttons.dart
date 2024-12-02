import 'components_list.dart'
    show
        AppColors,
        BorderRadius,
        CircularProgressIndicator,
        Color,
        Colors,
        ElevatedButton,
        Icon,
        IconData,
        RoundedRectangleBorder,
        SizeConfig,
        SizedBox,
        Text,
        TextStyle,
        VoidCallback,
        Widget,
        TextLine;

Widget buildRoundButton({
  required double width,
  required double height,
  double fontSize = 13,
  Color backgroundColor = AppColors.buttonColor,
  Color foregroundColor = AppColors.white,
  required String title,
  IconData? icon,
  bool isLoading = false,
  bool btnClick = false,
  bool isBold = false,
  double radius = 10,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: SizeConfig.blockSizeHorizontal = width,
    height: SizeConfig.blockSizeVertical = height,
    child: ElevatedButton(
      onPressed: isLoading == true ? () {} : onPressed,
      child: isLoading == true
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : TextLine(
              title: title,
              fontSize: fontSize,
              color: foregroundColor,
              isBold: true,
            ),
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    ),
  );
}

// Icon button function
Widget buildIconButton({
  required double width,
  required double height,
  double? fontSize,
  required Color backgroundColor,
  required Color foregroundColor,
  IconData? icon,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: foregroundColor,
        size: fontSize,
      ),
      label: const Text(
        "",
        style: TextStyle(
          fontSize: 1,
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
      ),
    ),
  );
}
