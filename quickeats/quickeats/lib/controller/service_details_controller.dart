import 'package:get/get.dart';

import 'controller_list.dart';

class ServiceDetailsController extends GetxController {
  var isLoading = true.obs;
  final serviceData = {}.obs;
  var selectedService=''.obs;

  serviceDetailsApi({required String serviceId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('user_id');
    isLoading.value = true;

    final data = await apiServices.postApi(
        AppUrl.getServiceDetailsUrl,
        {
          'user_id': id,
          'id':serviceId,
        },
        isData: true,
        isToken: true);

    if (data.isSuccess == true) {
      printTest('success');
      serviceData.value = data.data;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      // snackBar(isSuccess: data.isSuccess!, message: data.message);
    }
  }




}
