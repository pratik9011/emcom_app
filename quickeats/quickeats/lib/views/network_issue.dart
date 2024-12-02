import 'package:get/get.dart';

import 'view_list.dart'
    show AppBar, AppColors, BuildContext, Builder, Center, Colors, Column, CrossAxisAlignment, EdgeInsets, Get, Icon, Icons, Image, InkWell, MainAxisAlignment, Padding, Row, Scaffold, SplashScreen, StatelessWidget, Widget, buildRoundButton, dateLive, heightSpaceBox, TextLine, widthSpaceBox;

class NetworkIssue extends StatelessWidget {
  const NetworkIssue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextLine(title: dateLive(), fontSize: 15, isBold: true),
            widthSpaceBox(size: 5),
            const Icon(
              Icons.calendar_month,
              color: AppColors.textColor,
              size: 25,
            ),
          ],
        ),
        backgroundColor: AppColors.white,
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
                // onTap: () => Get.toNamed('/notification'),
                child: Icon(Icons.notifications_none)),
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Builder(
                  builder: (context) => InkWell(
                        child: Image.asset(
                          'assets/images/menu.png',
                          height: 25,
                          width: 25,
                        ),
                        onTap: () => Scaffold.of(context).openEndDrawer(),
                      )))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/images/No-connection-pana.png',
            height: 300,
          )),
          TextLine(
              title: 'Network Connection Issue', fontSize: 16, isBold: true),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextLine(
                title:
                    "Ensure you're connected to Wi-Fi or mobile data, and try again.",
                fontSize: 16,
                lines: 3),
          ),
          heightSpaceBox(size: 50),
          Center(
            child: buildRoundButton(
              width: 100,
              height: 45,
              title: "Refresh",
              onPressed: () {
                Get.offAll(const SplashScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
