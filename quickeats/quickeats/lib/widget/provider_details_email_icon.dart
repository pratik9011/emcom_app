import 'package:get/get.dart';

import 'widgetList.dart';
class ProviderDetailsEmailIcon extends StatelessWidget {
  const ProviderDetailsEmailIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderDetailsController());
    return Obx(() => controller.isLoading.isFalse
        ? CircleAvatar(
      radius: 25,
      backgroundColor: AppColors.greyShade1,
      child: IconButton(
        onPressed: () async {
          final now = DateTime.now();
          String subject = 'Gatiiman_customer_order_confirmation_email...';
          String message =
          '''\n\nWe are pleased to inform you that a new booking has been made for your service. Below are the details of the booking:\n$now\n${"translate(data.userInfoList['name'])"}
                                  \n+91${"data.userInfoList['mobile_no']"}
                                  \n${"data.userInfoList['email_id']"}
                                  \n- Please confirm the appointment with the customer at your earliest convenience.\n
                                  \n- If you need to reschedule or have any questions regarding this booking, contact us at https://gatiiman.com open app Cancel request .\n\n
                                  \nThank you for your attention to this booking. We appreciate your prompt action and look forward to a successful service delivery.
                                  \n\nBest regards,\n Gatiiman-App\n\n  [******don't Reply On this Mail*****]''';
          Uri(
            path: "serviceName['email_id']",
            query: "$subject,$message",
          );
          if (await launchUrl(Uri())) {
            Get.back();
          }
        },
        icon: const Icon(
          Icons.mail_outline,
          color: AppColors.buttonColor,
        ),
      ),
    )
        : const SizedBox());
  }
}
