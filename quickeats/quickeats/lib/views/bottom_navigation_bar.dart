import 'package:get/get.dart';

import 'view_list.dart';


class BottomNavigationBarExample extends StatelessWidget {
  const BottomNavigationBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.find<BottomNavigationController>();

    return Obx(()=> Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: BottomNavigationController.widgetOptions.elementAt(data.selectedIndex.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColors.white,
        showSelectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.home,
              size: SizeConfig.safeBlockVertical  = 30,
            ),
            label: translate('home'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.favorite_border_outlined,
              size: SizeConfig.safeBlockVertical = 30,
            ),
            label: translate('favorite'),
          ),
          // BottomNavigationBarItem(
          //   backgroundColor: Colors.white,
          //   icon: Icon(
          //     Icons.delivery_dining,
          //     size: SizeConfig.safeBlockVertical = 30,
          //   ),
          //   label: translate('order'),
          // ),

          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.account_circle_outlined,
              size: SizeConfig.safeBlockVertical  = 30,
            ),
            label: translate('Profile'),
          ),
        ],
        currentIndex: data.selectedIndex.value,
        selectedItemColor: AppColors.buttonColor,
        onTap: (index) {
          data.updateIndex(index);
        },
      ),
    ));
  }
}

