import 'package:flutter/cupertino.dart';

// import 'package:usvendor/utils/size_config.dart';
import 'components_list.dart'
    show
        AppColors,
        BuildContext,
        Color,
        FontWeight,
        SizeConfig,
        SizedBox,
        StatelessWidget,
        Text,
        TextAlign,
        TextOverflow,
        TextStyle,
        Widget;
import 'colors.dart';

class TextLine extends StatelessWidget {
  const TextLine(
      {super.key,
      required this.title,
      required this.fontSize,
      this.color = AppColors.textColor,
      this.isBold = false,
      this.textAlign,
      this.lines = 1});

  final String title;
  final double fontSize;
  final bool isBold;
  final int? lines;
  final Color color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      translate(title),
      maxLines: lines!,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        // height: 1,
        color: color,
        fontSize: fontSize,
        fontWeight: isBold == true ? FontWeight.bold : null,
      ),
    );
  }
}

String translate(String word) {
  return word
      .replaceAll('_', ' ')
      .split(' ')
      .map((word) => capitalize(word))
      .join(' ');
}

String capitalize(String word) {
  if (word.isEmpty) return word;
  return word[0].toUpperCase() + word.substring(1);
}

Widget rowTextLine({
  required String title,
  required double textWidth,
  required double fontSize,
  Color? color,
  bool isBold = false,
  int? lines = 1,
}) {
  title = translate(title);
  return SizedBox(
    width: SizeConfig.blockSizeHorizontal = textWidth,
    child: Text(
      title,
      maxLines: lines!,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color ?? AppColors.textColor,
        fontSize: SizeConfig.safeBlockVertical = fontSize,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}
