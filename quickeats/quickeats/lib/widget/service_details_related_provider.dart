import 'package:get/get.dart';

import '../config.dart';

class ServiceDetailsRelatedProvider extends StatelessWidget {
  const ServiceDetailsRelatedProvider({super.key});

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
                        title: "related_providers", fontSize: 13, isBold: true),
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
          height: 70.0 * controller.serviceData['related_providers'].length,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.serviceData['related_providers'].length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      title: TextLine(
                        title: controller.serviceData['related_providers']
                        [index]['name'] ??
                            '',
                        isBold: true,
                        fontSize: 12,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          controller.serviceData['related_providers'][index]
                          ['image'] ??
                              '',
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLine(
                              title: controller
                                  .serviceData['related_providers']
                              [index]['title'] ??
                                  '',
                              color: AppColors.buttonColor,
                              fontSize: 12),
                          TextLine(
                              title: controller
                                  .serviceData['related_providers']
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
