import 'package:get/get.dart';
import 'controller_list.dart';

class FavoriteController extends GetxController {
  var isLoading = true.obs;
  final providerList =[].obs;

  addFavoriteApi({required String providerId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('user_id');
    isLoading.value = true;
    final data = await apiServices.postApi(
        AppUrl.addToFavoriteUrl,
        {
          'user_id': id,
          'provider_id':providerId,
        },
        isData: false, isToken: true);

    if (data.isSuccess == true) {
      printTest('success');
      snackBar(isSuccess: data.isSuccess!, message: data.message);
      isLoading.value = false;
    } else {
      isLoading.value = false;
      snackBar(isSuccess: data.isSuccess!, message: data.message);
    }
  }


  getFavoriteListApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('user_id');
    isLoading.value = true;
    final data = await apiServices.postApi(
        AppUrl.getProviderFavoriteUrl,
        {
          'user_id': id,
        },
        isData: true, isToken: true);

    if (data.isSuccess == true) {
      printTest('success');
      providerList.value = data.data;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      snackBar(isSuccess: data.isSuccess!, message: data.message);
    }
  }

}