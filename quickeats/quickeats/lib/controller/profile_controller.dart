import 'dart:async';
import 'dart:developer';

import 'controller_list.dart'
    show
        AppUrl,
        FormState,
        Get,
        GlobalKey,
        HttpException,
        NetworkIssue,
        ServerMaintenanceScreen,
        SharedPreferences,
        SocketException,
        SplashScreen,
        TextEditingController,
        XFile,
        apiServices,
        json,
        jsonDecode,
        kDebugMode;
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var isButton = false.obs;
  final data = {}.obs;
  XFile? image;
  final imagePath = ''.obs;
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  getProfileApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    String userId = prefs.getString('UserId').toString();
    String authKey = prefs.getString('AuthKey').toString();
    if (kDebugMode) {
      print(userId);
      print('authKey');
      print(authKey);
    }
    try {
      isLoading(true);
      http.Response response = (await http.post(
        Uri.parse(AppUrl.getProfile),
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
        prefs.clear();
        Get.offAll(const SplashScreen());
      }
      if (res['common']['status'] == true) {
        nameController.text = res['data'][0]['name'];
        emailController.text = res['data'][0]['email'];
        mobileNoController.text = res['data'][0]['mobile_no'];
        data.value = res['data'][0];
        isLoading.value = false;
      } else if (res['common']['status'] == false) {}
    } finally {
      isLoading(false);
    }
  }

  Future<Map<String, dynamic>> updateProfile() async {
    try {
      isLoading.value = true;
      isButton.value = true;

      var prefs = await SharedPreferences.getInstance();
      var id = prefs.getString('UserId');
      var authKey = prefs.getString('AuthKey');

      Map<String, String> headers = {'Authorization': 'Bearer $authKey'};
      var request =
          http.MultipartRequest('POST', Uri.parse(AppUrl.updateProfile));

      request.fields.addAll({
        'user_id': id!,
        'email_id': emailController.text,
        'name': nameController.text,
      });

      request.headers.addAll(headers);

      // Add image if available
      if (imagePath.value.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'profile_image', imagePath.value));
      }

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      Get.back();
      final res = await http.Response.fromStream(response);
      Map<String, dynamic> data = json.decode(res.body) as Map<String, dynamic>;
      if (data['common']['user_login'] == false) {
        isButton.value = false;
        prefs.clear();
        Get.offAll(const SplashScreen());
      }
      // if (response.statusCode == 200) {
      if (data['common']['status'] == true) {
        getProfileApi();
        isButton.value = false;
      } else if (data['common']['status'] == false) {
        isButton.value = false;
      }

      return {
        'success': true,
        'message': 'Profile updated successfully',
        'data': jsonDecode(responseBody),
      };
    } on SocketException {
      log("No Internet Connection");
      Get.offAll(() => const NetworkIssue());
      return {
        'success': false,
        'message': 'Profile updated successfully',
      };
    } on HttpException {
      log("Server returned invalid response");
      Get.to(() => const ServerMaintenanceScreen());
      return {
        'success': false,
        'message': 'Profile updated successfully',
      };
    } on TimeoutException {
      log("Request Timeout");
      Get.to(() => const NetworkIssue());
      return {
        'success': false,
        'message': 'Profile updated successfully',
      };
    } catch (e) {
      log("Unexpected Error: $e");
      return {
        'success': false,
        'message': 'Profile updated successfully',
      };
    } finally {
      isButton.value = false;
      isLoading.value = false;
    }
  }

  deleteAccountApi() async {
    reasonController.clear();
    isLoading.value = true;
    isButton.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('UserId').toString();
    final res = await apiServices.postApi(
        AppUrl.deleteAccount,
        {
          'user_id': userId,
          'reasons': reasonController.text,
        },
        isData: true,
        isToken: true);
    if (res.isSuccess == true) {
      isLoading.value = false;
      isButton.value = false;
      prefs.clear();
      Get.offAllNamed('login');
      isLoading.value = false;
      // taskList.value = data2.data['task_list'];
    } else {
      prefs.clear();
      isLoading.value = false;
      Get.offAllNamed('login');
    }
  }
}
