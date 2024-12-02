import 'package:get/get.dart';

import 'widgetList.dart';

class ServiceDetailsCallIconWidget extends StatelessWidget {
  const ServiceDetailsCallIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceDetailsController());
    return Obx(
      () => controller.isLoading.isTrue
          ? const SizedBox()
          : CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.greyShade1,
              child: IconButton(
                onPressed: () async {
                  final call = Uri.parse(
                      'tel:+91 ${controller.serviceData['provider']['phone_no']}');
                  if (await canLaunchUrl(call)) {
                    launchUrl(call);
                  } else {
                    throw 'Could not launch $call';
                  }
                },
                icon: const Icon(
                  Icons.call,
                  color: AppColors.buttonColor,
                ),
              ),
            ),
    );
  }
}
