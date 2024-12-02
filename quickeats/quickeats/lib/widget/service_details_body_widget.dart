import 'package:get/get.dart';

import 'widgetList.dart';

class ServiceDetailsBody extends StatelessWidget {
  const ServiceDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceDetailsController());
    return Column(
      children: [
        Obx(
          () => controller.isLoading.isTrue
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    controller.serviceData['image'] ?? '',
                  ),
                ),
        ),
        Obx(
          () => controller.isLoading.isTrue
              ? const SizedBox()
              : Center(
                  child: TextLine(
                      title: controller.serviceData['name'] ?? '',
                      fontSize: 14,
                      color: AppColors.black,
                      isBold: true)),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ServiceDetailsCallIconWidget(),
            ServiceDetailsEmailIcon(),
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
                      title: controller.serviceData['description'] ?? '',
                      lines: 5,
                      fontSize: 10),
                ),
        ),
        // const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: TextLine(
        //       title: "included_services",
        //       fontSize: 12,
        //       color: AppColors.black,
        //       isBold: true),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: AppColors.white,
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: Column(
        //       children: [
        //         GetBuilder<HomeController>(builder: (data) {
        //           return Obx(() {
        //             return SizedBox(
        //               height: SizeConfig.blockSizeVertical = 100.0,
        //               child: ListView.builder(
        //                   itemCount: 10,
        //                   itemBuilder:
        //                       (BuildContext context, int index) {
        //                     return Column(
        //                       children: [
        //                         Obx(() => Container(
        //                           decoration: BoxDecoration(
        //                               border: Border.all(
        //                                   color:
        //                                   data.selectedService
        //                                       .value ==
        //                                       index
        //                                       ? AppColors
        //                                       .textColor
        //                                       : Colors.white),
        //                               borderRadius:
        //                               BorderRadius.circular(
        //                                   15)),
        //                           child: InkWell(
        //                             onTap: () {
        //                               serviceId.value = data
        //                                   .providerUnderServicesList[
        //                               index]['id']
        //                                   .toString();
        //                               data.updateSelectedIndex(
        //                                   index);
        //                             },
        //                             child: Row(
        //                               children: [
        //                                 Padding(
        //                                   padding:
        //                                   const EdgeInsets.all(
        //                                       8.0),
        //                                   child: Container(
        //                                       width: 70,
        //                                       height: 70,
        //                                       decoration:
        //                                       BoxDecoration(
        //                                           borderRadius:
        //                                           BorderRadius
        //                                               .circular(
        //                                               10),
        //                                           image: DecorationImage(
        //                                               fit: BoxFit.cover,
        //                                               image: NetworkImage(
        //                                                 data.providerUnderServicesList[index]
        //                                                 [
        //                                                 'image'],
        //                                               )))),
        //                                 ),
        //                                 Column(
        //                                   crossAxisAlignment:
        //                                   CrossAxisAlignment
        //                                       .start,
        //                                   children: [
        //                                     Row(
        //                                       children: [
        //                                         rowTextLine(
        //                                           title:
        //                                           data.providerUnderServicesList[
        //                                           index]
        //                                           ['name'],
        //                                           lines: 1,
        //                                           fontSize: 13,
        //                                           isBold: true,
        //                                           textWidth: 150,
        //                                         ),
        //                                       ],
        //                                     ),
        //                                     TextLine(
        //                                         title:
        //                                         "₹ ${data.providerUnderServicesList[index]['price']}",
        //                                         fontSize: 10,
        //                                         isBold: true,
        //                                         color: AppColors
        //                                             .black),
        //                                     rowTextLine(
        //                                         title: data.providerUnderServicesList[
        //                                         index]
        //                                         ['description'],
        //                                         fontSize: 10,
        //                                         lines: 3,
        //                                         isBold: false,
        //                                         color:
        //                                         AppColors.black,
        //                                         textWidth: 210),
        //                                   ],
        //                                 ),
        //
        //                                 // child: Image.asset(ImageAssets().servicesImage,height: SizeConfig.blockSizeVertical =100,width: SizeConfig.blockSizeHorizontal =100, fit: BoxFit.cover,))
        //                               ],
        //                             ),
        //                           ),
        //                         )),
        //                         heightSpaceBox(size: 5),
        //                       ],
        //                     );
        //                   }),
        //             );
        //           });
        //         }),
        //         const Divider(
        //           height: 5,
        //           thickness: 1,
        //           color: Colors.grey,
        //         ),
        //         TextLine(
        //           title:
        //               "get_the_best_and_most_durable_wooden_furniture_",
        //           fontSize: 12,
        //           lines: 2,
        //         ),
        //         heightSpaceBox(size: 10),
        //       ],
        //     ),
        //   ),
        // ),
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
