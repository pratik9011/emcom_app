import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../config.dart'
    show AppColors, AppUrl, Get, LaunchMode, json, launchUrl, showStatusPopup;

class GetPolicyController extends GetxController {
  RxString pageUrl = ''.obs;
  RxBool isFirstLoadRunning= true.obs;
  var privacyData=[].obs;

  getPolicy({required String slug}) async {
    try {
      Get.dialog(
          barrierDismissible: false,
          const AlertDialog(
              backgroundColor: Colors.white,
              title: Center(child: Text("Loading")),
              actions: [
                Center(
                    child: Text(
                  "Please Wait for Response",
                  textAlign: TextAlign.center,
                )),
                Center(
                  child: CircularProgressIndicator(
                    color: AppColors.buttonColor,
                  ),
                ),
              ]));
      pageUrl.value = '';
      // isFirstLoadRunning.value = true;
      http.Response response = (await http.post(
        Uri.parse(AppUrl.getHelpSupport),
        headers: {
          'Authorization': 'Bearer demo',
        },
        body: {
          'slug': slug,
        },
      ));

      Map<String, dynamic> res =
          json.decode(response.body) as Map<String, dynamic>;
      if (res['common']['status'] == true) {
        Get.back();
        pageUrl.value = res['data'][0]['url'].toString();

        if (!await launchUrl(
          Uri.parse('${pageUrl.value}?key=demo'),
          mode: LaunchMode.inAppWebView,
        )) {
          throw Exception('Could not launch');
        }
      } else if (res['common']['status'] == false) {
        showStatusPopup(
            title: "warning",
            content: res['common']['message'],
            onPressed: () => Get.offAllNamed('mainPage'));
      } else if (res.isEmpty) {
        showStatusPopup(
            title: 'data_not_found',
            content: 'data_not_found_back_to_home',
            onPressed: () => Get.offAllNamed('serverMaintenancePage'));
      }
    } finally {
    }
  }
}
