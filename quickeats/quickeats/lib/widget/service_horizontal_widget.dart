import 'package:get/get.dart';

import 'widgetList.dart';

class ServiceHorizontal extends StatelessWidget {
  const ServiceHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Obx(
      () => controller.isLoading.isTrue
          ? const SizedBox()
          : SizedBox(
              height: SizeConfig.blockSizeVertical = 90,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoryList.length,
                itemBuilder: (BuildContext context, int index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => SubService(
                                categoryId:
                                    controller.categoryList[index]['id'],
                                categoryName: controller.categoryList[index]
                                    ['name'],
                              ));
                        },
                        child: Container(
                          height: SizeConfig.blockSizeVertical = 60,
                          width: SizeConfig.blockSizeHorizontal = 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.buttonColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: NetworkImage(
                              controller.categoryList[index]['image'] ?? '',
                            )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: SizeConfig.blockSizeHorizontal = 70,
                        child: TextLine(
                            title: controller.categoryList[index]['name'] ?? '',
                            fontSize: 12,
                            lines: 1,
                            isBold: false)),
                  ],
                ),
              ),
            ),
    );
  }
}
