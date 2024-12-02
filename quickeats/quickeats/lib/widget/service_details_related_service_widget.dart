import 'package:get/get.dart';

import 'widgetList.dart';
class ServiceDetailsRelatedService extends StatelessWidget {
  const ServiceDetailsRelatedService({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceDetailsController());
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextLine(
                        title: "related_service", fontSize: 13, isBold: true),
                  ],
                ),
              ),
              Divider(
                height: 10,
                thickness: 1,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        Obx(() => controller.isLoading.isTrue
            ? const SizedBox()
            : SizedBox(
          height: 70.0 * controller.serviceData['related_services'].length,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.serviceData['related_services'].length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      title: TextLine(
                        title: controller.serviceData['related_services']
                        [index]['name'] ??
                            '',
                        isBold: true,
                        fontSize: 12,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          controller.serviceData['related_services'][index]
                          ['image'] ??
                              '',
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLine(
                              title:
                              "₹${controller.serviceData['related_services'][index]['price'] ?? ''}",
                              color: AppColors.buttonColor,
                              fontSize: 12),
                          TextLine(
                              title:
                              controller.serviceData['related_services']
                              [index]['description'] ??
                                  '',
                              fontSize: 12)
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )),
      ],
    );
  }
}
