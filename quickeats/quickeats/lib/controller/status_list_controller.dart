
import 'controller_list.dart'
    show AppUrl, Get,SharedPreferences, SplashScreen, json;
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class StatusListController extends GetxController {
  var isLoading = true.obs;
  RxList statusList = [].obs;

  getStatusApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    String userId = prefs.getString('UserId').toString();
    String authKey = prefs.getString('AuthKey').toString();

    try {
      isLoading(true);
      http.Response response = (await http.post(
        Uri.parse(AppUrl.getStatus),
        headers: {
          'Authorization': 'Bearer $authKey',
        },
        body: {
          'user_id': userId,
        },
      ));

      Map<String, dynamic> res =
          json.decode(response.body) as Map<String, dynamic>;
      if (res['common']['user_login'] == false) {
        Get.offAll(const SplashScreen());
      }
      if (res['common']['status'] == true) {
        statusList.value = res['data'];
        isLoading.value = false;
      } else if (res['common']['status'] == false) {}
    } finally {
      isLoading(false);
    }
  }
}
