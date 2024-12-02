import 'package:get/get.dart';

import 'controller_list.dart';

class ProviderDetailsController extends GetxController {
  var isLoading = true.obs;
  final providerData = {}.obs;
  final providerUnderServicesList = [].obs;

  providerDetailsApi({required String providerId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // providerUnderServicesApi(providerId: providerId);
    String? id = pref.getString('user_id');
    isLoading.value = true;
    final data = await apiServices.postApi(
        AppUrl.getProviderDetailsUrl,
        {
          'user_id': id,
          'id': providerId,
        },
        isData: true,
        isToken: true);

    if (data.isSuccess == true) {
      printTest('success');
      printTest(data.data);
      providerData.value = data.data;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      snackBar(isSuccess: data.isSuccess!, message: data.message);
    }
  }

  providerUnderServicesApi({required String providerId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('user_id');
    isLoading.value = true;
    final data = await apiServices.postApi(
        AppUrl.getServiceUrl,
        {
          'user_id': id,
          'provider_id': providerId,
        },
        isData: true,
        isToken: true);

    if (data.isSuccess == true) {
      printTest('success');
      printTest(data.data);
      providerUnderServicesList.value = data.data;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      // snackBar(isSuccess: data.isSuccess!, message: data.message);
    }
  }
}
