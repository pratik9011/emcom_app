import 'package:get/get.dart';

import 'widgetList.dart';

class ProviderUnderService extends StatelessWidget {
  const ProviderUnderService({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderDetailsController());
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
                    TextLine(title: "services", fontSize: 13, isBold: true),
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
                height: 70.0 * controller.providerUnderServicesList.length,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.providerUnderServicesList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(()=>ServiceDetails(serviceId: controller.providerUnderServicesList[index]['id']??'', serviceName: controller.providerUnderServicesList[index]['name']??''));
                        },
                        child: Card(
                          color: Colors.white,
                          child: ListTile(
                            title: TextLine(
                              title: controller.providerUnderServicesList[index]['name'] ?? '',
                              isBold: true,
                              fontSize: 12,
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                controller.providerUnderServicesList[index]['image'] ?? '',
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextLine(
                                    title:
                                        "₹${controller.providerUnderServicesList[index]['price'] ?? ''}",
                                    color: AppColors.buttonColor,
                                    fontSize: 12),
                                TextLine(
                                    title: controller.providerUnderServicesList[
                                            index]['description'] ??
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
