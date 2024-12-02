import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:get/get.dart';

import 'widgetList.dart';

class ProviderWidget extends StatelessWidget {
  const ProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Obx(
      () => SizedBox(
        height: controller.providerList.length / 2 == 0
            ? 0
            : 155 + 310.0 * controller.providerList.length / 2,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              mainAxisExtent: 300),
          padding: const EdgeInsets.all(8.0),
          itemCount: controller.providerList.length,
          itemBuilder: (context, index) {
            return Obx(
              () => controller.isLoading.isTrue
                  ? const SizedBox()
                  :controller.isSearch.isTrue? const SizedBox():InkWell(
                onTap: () {
                },
                child: Card(
                  color: AppColors.white,
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            controller.providerList[index]['image'],
                            height: 160,
                            width: 160,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: TextLine(
                            title: controller.providerList[index]
                            ['name'] ??
                                '',
                            color: Colors.black,
                            fontSize: 14,
                            lines: 1,
                            isBold: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: TextLine(
                            title: controller.providerList[index]
                            ['title'] ??
                                '',

                            fontSize: 14,
                            isBold: false),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: TextLine(
                            title: controller.providerList[index]
                            ['offer_rate'] ?? '',
                            fontSize: 14,
                            color: Colors.black,
                            isBold: true),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 20,
                                child: RatingBar.readOnly(
                                  isHalfAllowed: true,
                                  size: 15,
                                  alignment: Alignment.center,
                                  filledIcon: Icons.star,
                                  emptyIcon: Icons.star_border,
                                  emptyColor: Colors.black,
                                  filledColor: Colors.black,
                                  halfFilledColor: Colors.black,
                                  halfFilledIcon: Icons.star_half,
                                  initialRating: 3.5,
                                  maxRating: 5,
                                ),
                              ),
                              Row(
                                children: [
                                  TextLine(
                                      title: controller
                                          .providerList[index]['rating_count']
                                          .toString(),
                                      fontSize: 12),
                                ],
                              ),
                            ],
                          )),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
