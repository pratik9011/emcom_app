import 'package:get/get.dart';
import '../config.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => TaskDetailsController());
    Get.lazyPut(() => StatusListController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => BottomNavigationController());
  }
}
