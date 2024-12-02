import 'package:get/get.dart';
import 'package:quickeats/config.dart';

dynamic snackBar({required bool isSuccess, required String message}) {
  return Get.snackbar(isSuccess ? translate('success') : translate('failed'),
      translate(message),
      colorText: AppColors.white,
      backgroundColor: isSuccess?AppColors.buttonColor:AppColors.red,
      snackPosition: SnackPosition.TOP);
}
