import 'components_list.dart'
    show BuildContext, MediaQuery,  SizedBox, Widget;

class SizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    blockSizeHorizontal = (screenWidth! / 100);
    blockSizeVertical = screenHeight! / 100;

    _safeAreaVertical = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaVertical!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }
}

Widget heightSpaceBox({
  required double size,
}) {
  return SizedBox(
    height: SizeConfig.blockSizeVertical = size,
  );
}

Widget widthSpaceBox({
  required double size,
}) {
  return SizedBox(
    width: SizeConfig.blockSizeHorizontal = size,
  );
}

double widthSize(double size) {
  return SizeConfig.blockSizeHorizontal = size;
}

double heightSize(double size) {
  return SizeConfig.blockSizeVertical = size;
}

Future<double> textSize(double size) async {
  return SizeConfig.safeBlockVertical = size;
}
