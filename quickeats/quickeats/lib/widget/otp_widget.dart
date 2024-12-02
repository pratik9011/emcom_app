import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:quickeats/views/register_screen.dart';

import 'widgetList.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key,this.testMood=false});
  final bool testMood;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Column(
      children: <Widget>[
        OTPTextField(
          controller: controller.otpController,
          length: 6,
          fieldStyle: FieldStyle.box,
          width: MediaQuery.of(context).size.width,
          fieldWidth: SizeConfig.blockSizeHorizontal = 45,
          style: TextStyle(
            fontSize: SizeConfig.safeBlockVertical = 20,
            fontWeight: FontWeight.w700,
          ),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          keyboardType: TextInputType.number,
          onChanged: (pin) {
            controller.otp.value = pin.toString();
            debugPrint(pin);
            if (pin.length == 6) {
              controller.verifyOTPApi();
            }
          },
        ),
        SizedBox(height: SizeConfig.blockSizeVertical = 40),
        Obx(() => buildRoundButton(
            width: double.infinity,
            height: 50,
            title: AppStrings.sendOTP,
            isLoading: controller.isLoading.value,
            onPressed: () {
              if(testMood){
                Get.to(()=> const RegisterScreen());
              }else{
                controller.verifyOTPApi();
              }
            })),
        SizedBox(height: SizeConfig.blockSizeVertical = 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: SizeConfig.blockSizeHorizontal = 5),
            const TextLine(
              title: "Don't received the OTP? Wait",
              fontSize: 14,
              color: AppColors.textColor,
              lines: 2,
            ),
            Obx(() => GestureDetector(
              onTap: controller.seconds.value == 0
                  ? () {
                controller.sendOTPApi();
              }
                  : () {},
              child: controller.seconds.value == 0
                  ? const TextLine(
                title: "__resend",
                isBold: true,
                fontSize: 14,
                color: AppColors.buttonColor,
              )
                  : TextLine(
                title: "  ${controller.seconds} seconds",
                fontSize: 14,
                color: AppColors.buttonColor,
                isBold: true,
              ),
            )),
          ],
        ),
      ],
    );
  }
}
