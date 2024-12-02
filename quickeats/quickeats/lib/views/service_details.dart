import 'package:get/get.dart';

import 'view_list.dart';

class ServiceDetails extends StatelessWidget {
  const ServiceDetails(
      {super.key, required this.serviceId, required this.serviceName});

  final String serviceId;
  final String serviceName;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceDetailsController());
    controller.serviceDetailsApi(serviceId: serviceId);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: appBarName(name: serviceName ?? ''),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Card(
            color: AppColors.whiteShade1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ServiceDetailsBody(),
                ServiceDetailsRelatedService(),
                ServiceDetailsRelatedProvider(),
                ServiceDetailsReview(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:const CallNowButton(),
    );
  }
}


