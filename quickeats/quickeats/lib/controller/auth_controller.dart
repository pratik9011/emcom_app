import 'dart:async';

import 'package:otp_text_field/otp_field.dart';
import 'package:quickeats/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:quickeats/res/components/print.dart';
import 'package:quickeats/views/register_screen.dart';
import 'controller_list.dart'
    show
        AppUrl,
        FormState,
        Get,
        GlobalKey,
        TextEditingController,
        apiServices,
        errorShowDialog;
import 'package:get/get.dart'
    show
        BoolExtension,
        Get,
        GetNavigation,
        GetxController,
        IntExtension,
        RxInt,
        RxString,
        StringExtension;

class AuthController extends GetxController {
  var isLoading = false.obs;
  final name = TextEditingController();
  final email = TextEditingController();
  final mobileNo = TextEditingController();
  final password = TextEditingController();
  final otpController = OtpFieldController();
  RxString otp = ''.obs;
  RxString mobileNOString = ''.obs;
  RxInt seconds = 0.obs;
  late Timer _timer;

  final formKey = GlobalKey<FormState>();

  sendOTPApi() async {
    mobileNOString.value = mobileNo.text.trim();
    isLoading.value = true;
    final data = await apiServices.postApi(
        AppUrl.sendOtpUrl,
        {
          'mobile_no': mobileNOString.value,
        },
        isData: true);
    mobileNo.text = mobileNo.text;
    if (data.isSuccess == true) {
      isLoading.value = false;
      Fluttertoast.showToast(
          msg: data.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.buttonColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Get.to(() => const OTPScreen());
      seconds.value = 60;
      startTimer();
    } else {
      isLoading.value = false;
      snackBar(isSuccess: data.isSuccess!, message: data.message);
    }
  }

  verifyOTPApi() async {
    isLoading.value = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    printTest(mobileNo.text);
    printTest(otp.value);

    try {
      http.Response response = (await http.post(
        Uri.parse(AppUrl.verifyOtpUrl),
        headers: {
          'Authorization': 'Bearer demo',
        },
        body: {
          'mobile_no': mobileNo.text.trim(),
          'otp': otp.value,
        },
      ));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        printTest(data);
        if (data['common']['status'] == true) {
          isLoading.value = false;
          if (data['data']['is_user_exist'] == true) {
            pref.setString('auth_key', data['user']['auth_key']);
            pref.setString('user_id', data['user']['id']);
            Get.offAllNamed(AppStrings.mainPage);
          } else {
            Get.to(() => const RegisterScreen());
          }
        } else {
          isLoading.value = false;
          errorShowDialog(
            title: AppStrings.login,
            content: data['common']['message'] ?? 'Something went wrong.',
            onPressed: () => Get.back(),
          );
        }
      } else {
        isLoading.value = false;
        errorShowDialog(
          title: AppStrings.login,
          content: 'Error: ${response.statusCode}',
          onPressed: () => Get.back(),
        );
      }
    } catch (e) {
      isLoading.value = false;
      errorShowDialog(
        title: AppStrings.login,
        content: 'Error: $e',
        onPressed: () => Get.back(),
      );
    }
  }

  registerApi() async {
    isLoading.value = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    printTest(mobileNo.text);
    printTest(otp.value);
    try {
      http.Response response = (await http.post(
        Uri.parse(AppUrl.registerUrl),
        headers: {
          'Authorization': 'Bearer demo',
        },
        body: {
          'mobile_no': mobileNo.text.trim(),
          'otp': otp.value,
          'name': name.text.trim(),
          'email_id': email.text.trim(),
          'type':'1',
        },
      ));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        printTest(data);
        if (data['common']['status'] == true) {
          isLoading.value = false;

          pref.setString('auth_key', data['user']['auth_key']);
          pref.setString('user_id', data['user']['id']);
          Get.offAllNamed(AppStrings.mainPage);
        } else {
          isLoading.value = false;
          errorShowDialog(
            title: AppStrings.login,
            content: data['common']['message'] ?? 'Something went wrong.',
            onPressed: () => Get.back(),
          );
        }
      } else {
        isLoading.value = false;
        errorShowDialog(
          title: AppStrings.login,
          content: 'Error: ${response.statusCode}',
          onPressed: () => Get.back(),
        );
      }
    } catch (e) {
      isLoading.value = false;
      errorShowDialog(
        title: AppStrings.login,
        content: 'Error: $e',
        onPressed: () => Get.back(),
      );
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        _timer.cancel();
      }
    });
  }
}
