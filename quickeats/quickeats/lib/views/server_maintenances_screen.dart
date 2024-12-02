import 'package:get/get_navigation/get_navigation.dart';

import 'view_list.dart'
    show
        AssetImage,
        BoxDecoration,
        BuildContext,
        Center,
        Column,
        Container,
        DecorationImage,
        Get,
        Scaffold,
        SplashScreen,
        StatelessWidget,
        Widget,
        buildRoundButton,
        heightSpaceBox,
        TextLine;

class ServerMaintenanceScreen extends StatelessWidget {
  const ServerMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // checkInternetAndShowPopup();

    return Scaffold(
        body: Column(children: [
      Container(
        height: 300,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icon/ServerFail.png'),
          ),
        ),
      ),
      TextLine(title: "server_is_down_temporary", fontSize: 20, isBold: true),
      heightSpaceBox(size: 20),
      TextLine(
          title: "Please check back later. We apologize for the inconvenience.",
          lines: 3,
          fontSize: 15),
      heightSpaceBox(size: 20),
      Center(
        child: buildRoundButton(
          width: 200,
          height: 50,
          title: "Check",
          onPressed: () {
            Get.offAll(const SplashScreen());
          },
        ),
      ),
    ]));
  }
}
