import 'package:get/get.dart';

import 'widgetList.dart';

class ProviderFavoriteListWidget extends StatelessWidget {
  const ProviderFavoriteListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());

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
                  : InkWell(
                onTap: () {
                  Get.to(() => ProviderDetailsScreen(
                      providerId: controller.providerList[index]['id'],
                      providerName: controller.providerList[index]
                      ['name']));
                },
                child: Card(
                  color: AppColors.white,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            controller.providerList[index]['image'],
                            height: 160,
                            width: 200,
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.buttonColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50)),
                              ),
                              child: const Center(
                                  child: TextLine(
                                      title: '20%',
                                      fontSize: 12,
                                      color: AppColors.white)),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: 25,
                                  color: AppColors.textColor,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextLine(
                            title: controller.providerList[index]
                            ['name'] ??
                                '',
                            fontSize: 14,
                            isBold: true),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const TextLine(
                                      title: 'experience_', fontSize: 10),
                                  TextLine(
                                    title:
                                    "${controller.providerList[index]['experience'] ?? ''}${controller.providerList[index]['experience_type'] ?? ''}",
                                    fontSize: 10,
                                    isBold: true,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  TextLine(
                                      title: controller
                                          .providerList[index]['rating']
                                          .toString(),
                                      fontSize: 12),
                                ],
                              ),
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: const Card(
                              color: AppColors.whiteShade1,
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.favorite_border_outlined,
                                ),
                              ),
                            ),
                            onTap: () {
                              final controllerFav =
                              Get.put(FavoriteController());
                              controllerFav.addFavoriteApi(
                                  providerId: controller
                                      .providerList[index]['id'] ??
                                      '');
                            },
                          ),
                          InkWell(
                            child: const Card(
                              color: AppColors.buttonColor,
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: TextLine(
                                    title: "book now",
                                    fontSize: 10,
                                    color: AppColors.white,
                                    isBold: true),
                              ),
                            ),
                            onTap: () {
                              Get.to(() => ProviderDetailsScreen(
                                  providerId: controller
                                      .providerList[index]['id'] ??
                                      "",
                                  providerName: controller
                                      .providerList[index]['name'] ??
                                      ''));
                            },
                          )
                        ],
                      )
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
