import 'package:get/get.dart';

import 'widgetList.dart';

class CallNowButton extends StatelessWidget {
  const CallNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceDetailsController());
    return Container(
      padding: const EdgeInsets.all(10),
      child: buildRoundButton(
          width: 700,
          height: 50,
          title: "call_now",
          onPressed: () {
            lunchCall(number: controller.serviceData['provider']['phone_no'] ?? '');
          },
          backgroundColor: AppColors.buttonColor,
          foregroundColor: AppColors.white),
    );
  }
}




class CallNowButtonProvider extends StatelessWidget {
  const CallNowButtonProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderDetailsController());
    return Container(
      padding: const EdgeInsets.all(10),
      child: buildRoundButton(
          width: 700,
          height: 50,
          title: "call_now",
          onPressed: () {
            lunchCall(number: controller.providerData['phone_no'] ?? '');
          },
          backgroundColor: AppColors.buttonColor,
          foregroundColor: AppColors.white),
    );
  }
}
