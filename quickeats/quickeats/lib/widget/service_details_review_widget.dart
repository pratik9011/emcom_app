import 'package:get/get.dart';

import 'widgetList.dart';
class ServiceDetailsReview extends StatelessWidget {
  const ServiceDetailsReview({super.key});

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
                    TextLine(title: "reviews", fontSize: 13, isBold: true),
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
        Obx(
              () => controller.isLoading.isTrue
              ? const SizedBox()
              : Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: SizedBox(
              height: 70.0 *
                  controller.serviceData['provider']['review'].length,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                controller.serviceData['provider']['review'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          controller.serviceData['provider']['review']
                          [index]['created_image'] ??
                              ''),
                    ),
                    title: TextLine(
                      title: controller.serviceData['provider']['review']
                      [index]['created_by'] ??
                          '',
                      fontSize: 13,
                      isBold: true,
                    ),
                    subtitle: TextLine(
                      title: controller.serviceData['provider']['review']
                      [index]['comment'] ??
                          '',
                      fontSize: 13,
                      isBold: false,
                    ),
                    // trailing: RatingBar(
                    //   initialRating: double.parse(
                    //       serviceName["review"][index]['rating']),
                    //   direction: Axis.horizontal,
                    //   allowHalfRating: true,
                    //   itemCount: 5,
                    //   itemSize: 10,
                    //   ratingWidget: RatingWidget(
                    //     full: const Icon(
                    //       Icons.star,
                    //       color: Colors.amber,
                    //     ),
                    //     half: const Icon(Icons.star_half),
                    //     empty: const Icon(
                    //       Icons.star,
                    //       color: Colors.grey,
                    //     ),
                    //   ),
                    //   itemPadding:
                    //   const EdgeInsets.symmetric(horizontal: 0.0),
                    //   onRatingUpdate: (rating) {
                    //     if (kDebugMode) {
                    //       print(rating);
                    //     }
                    //   },
                    // ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
