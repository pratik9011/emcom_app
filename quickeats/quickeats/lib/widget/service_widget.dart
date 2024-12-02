import 'package:get/get.dart';

import 'widgetList.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => SizedBox(
          width: double.infinity,
          height: 107.0 * controller.serviceList.length,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.serviceList.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => controller.isLoading.isTrue
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            Get.to(() => ServiceDetails(
                                  serviceId: controller.serviceList[index]
                                      ['provider_id']??'', serviceName: controller.serviceList[index]
                            ['name']??'',
                                ));
                          },
                          child: Card(
                            color: Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  controller.serviceList[index]['image'] ?? '',
                                ),
                              ),
                              title: TextLine(
                                title:
                                    controller.serviceList[index]['name'] ?? '',
                                fontSize: 12,
                                isBold: true,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextLine(
                                      title: controller.serviceList[index]
                                              ['provider_name'] ??
                                          '',
                                      fontSize: 12),
                                  TextLine(
                                      title: controller.serviceList[index]
                                              ['provider_title'] ??
                                          '',
                                      fontSize: 12),
                                  TextLine(
                                    title:
                                        "₹${controller.serviceList[index]['price'] ?? ''}",
                                    fontSize: 17,
                                    isBold: true,
                                    color: AppColors.buttonColor,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 15,
                                      ),
                                      TextLine(
                                        title: controller.serviceList[index]
                                                ['provider_rating']
                                            .toString(),
                                        fontSize: 12,
                                        isBold: true,
                                        color: AppColors.textColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                );
              }),
        ),
      ),
    );
  }
}
