import 'package:quickeats/config.dart';

import 'controller_list.dart'
    show HomeScreen, NotificationScreen, ProfileScreen, TaskScreen, Widget;
import 'package:get/get.dart' show GetxController, IntExtension;

class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;

  static final List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const FavoriteScreen(),
    // const HomeScreen(),
    // const NotificationScreen(),
    const ProfileScreen(),
  ];

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
