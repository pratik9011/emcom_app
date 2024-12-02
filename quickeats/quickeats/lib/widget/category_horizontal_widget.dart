import 'package:get/get.dart';
import 'package:quickeats/config.dart';

import 'widgetList.dart'
    show
        AppColors,
        Axis,
        BuildContext,
        ClampingScrollPhysics,
        Container, EdgeInsets,
        Get,
        HomeController,
        ListView,
        Padding,
        SizedBox,
        StatelessWidget,
        TextLine,
        Widget;

class CategoryHorizontalWidget extends StatelessWidget {
  const CategoryHorizontalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Obx(
      () => controller.isLoading.isTrue
          ? const SizedBox()
          : Container(
        color: AppColors.whiteShade1,
              height: 40,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoryList.length,
                itemBuilder: (BuildContext context, int index) =>
                    Card(
                   color: AppColors.white,
                    elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextLine(
                        title: controller.categoryList[index]['name'] ?? '',
                        fontSize: 12,
                        lines: 1,
                        isBold: true),
                  ),
                ),
              ),
            ),
    );
  }
}
