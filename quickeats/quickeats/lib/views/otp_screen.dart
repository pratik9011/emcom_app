import 'package:get/get.dart';
import 'package:quickeats/widget/otp_widget.dart';
import 'view_list.dart';
class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            heightSpaceBox(size: 20),
            Center(child: Image.asset(AssetsImage.logoBig, height: 50, width: Get.width * 0.6,)),
            // heightSpaceBox(size: Get.height * 0.15),
            Container(
              padding: const EdgeInsets.all(29.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TextLine(
                    title: 'Verification',
                    color: AppColors.textColor,
                    isBold: true,
                    lines: 1,
                    fontSize: 28,
                  ),
                  // heightSpaceBox(size: Get.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.offAllNamed('login');
                          },
                          child: const TextLine(
                              title: " Change",
                              fontSize: 15,
                              isBold: true,
                              color: AppColors.buttonColor),
                        ),
                      ],
                    ),
                  ),
                  const TextLine(
                      title:
                      "We’ve sent a OTP to the mobile number above. Please enter it to complete verification.",
                      fontSize: 14,
                      color: AppColors.textColor,
                      lines: 3),
                  SizedBox(height: SizeConfig.blockSizeVertical = 20),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: TextLine(
                            title: "Enter OTP", fontSize: 14, isBold: true),
                      ),
                    ],
                  ),
                  const OtpWidget(testMood: false,)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
