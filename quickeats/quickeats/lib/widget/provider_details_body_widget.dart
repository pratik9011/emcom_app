import 'package:get/get.dart';

import 'widgetList.dart';
class ProviderDetailsBody extends StatelessWidget {
  const ProviderDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderDetailsController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
              () => controller.isLoading.isTrue
              ? const SizedBox()
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              controller.providerData['image'] ?? '',
            ),
          ),
        ),
        Obx(
              () => controller.isLoading.isTrue
              ? const SizedBox()
              : Center(
              child: TextLine(
                  title: controller.providerData['name'] ?? '',
                  fontSize: 14,
                  color: AppColors.black,
                  isBold: true)),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ProviderDetailsCallIcon(),
            ProviderDetailsEmailIcon(),
          ]),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TextLine(title: "description", fontSize: 12, isBold: true),
        ),
        Obx(
              () => controller.isLoading.isTrue
              ? const SizedBox()
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextLine(
                title: controller.providerData['description'] ?? '',
                lines: 5,
                fontSize: 10),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TextLine(
              title: "*_disclaimer",
              fontSize: 13,
              isBold: true,
              color: AppColors.black),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TextLine(
              title:
              "you_will_only_get_one_serviceman_for_each_service_._more_than_one_serviceman_will_cost_additional_expenses.",
              fontSize: 12,
              lines: 5,
              isBold: false,
              color: AppColors.red),
        ),
      ],
    );
  }
}
