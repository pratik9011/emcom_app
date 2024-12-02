import 'dart:async';
import 'dart:developer';

import 'package:quill_html_editor/quill_html_editor.dart'
    show QuillEditorController;

import 'controller_list.dart'
    show
        AppUrl,
        Colors,
        FontWeight,
        Get,
        HttpException,
        NetworkIssue,
        ServerMaintenanceScreen,
        SharedPreferences,
        SocketException,
        SplashScreen,
        TextEditingController,
        TextStyle,
        apiServices,
        checkInternetAndShowPopup,
        json,
        kDebugMode,
        showStatusPopup;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TaskDetailsController extends GetxController {
  var isLoading = true.obs;
  var isButton = false.obs;
  final data = {}.obs;
  final images = [].obs;
  List images2 = [];

  final fileData = [].obs;
  final comment = QuillEditorController();
  final statusCtr = TextEditingController();
  final departmentCtr = TextEditingController();
  final assigneeCtr = TextEditingController();
  var editorTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal);
  var hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);

  // getTaskDetailsApi({required String taskId}) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   isLoading.value = true;
  //   String userId = prefs.getString('UserId').toString();
  //   String authKey = prefs.getString('AuthKey').toString();
  //   if (kDebugMode) {
  //     print(userId);
  //     print(taskId);
  //     print('task_details_api_is_hits');
  //     print(authKey);
  //   }
  //   try {
  //     isLoading(true);
  //     http.Response response = (await http.post(
  //       Uri.parse(AppUrl.geTaskDetails),
  //       headers: {
  //         'Authorization': 'Bearer $authKey',
  //       },
  //       body: {
  //         'user_id': userId,
  //         'task_id': taskId,
  //       },
  //     ));
  //
  //     Map<String, dynamic> res =
  //         json.decode(response.body) as Map<String, dynamic>;
  //
  //     if (res['common']['user_login'] == false) {
  //       prefs.clear();
  //       Get.offAll(const SplashScreen());
  //     }
  //
  //     if (res['common']['status'] == true) {
  //       departmentCtr.text = res['data']['department'].toString();
  //       assigneeCtr.text = res['data']['assignee'].toString();
  //       statusCtr.text = res['data']['status'].toString();
  //       data.value = res['data'];
  //       isLoading.value = false;
  //     } else if (res['common']['status'] == false) {}
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  getTaskDetailsApi({required String taskId}) async {
    isLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('UserId').toString();
    final res = await apiServices.postApi(
        AppUrl.geTaskDetails,
        {
          'user_id': userId,
          'task_id': taskId,
        },
        isData: true,
        isToken: true);
    if (res.isSuccess == true) {
      departmentCtr.text = res.data['department'].toString();
      assigneeCtr.text = res.data['assignee'].toString();
      statusCtr.text = res.data['status'].toString();
      data.value = res.data;
      isLoading.value = false;
    } else {
      isLoading.value = true;
    }
  }

  addTaskDetailsApi({required String taskId}) async {
    String? htmlText = await comment.getText();
    String? statusId = statusCtr.text;
    try {
      if (statusId.isEmpty || htmlText == '') {
        showStatusPopup(
            title: "error",
            content: "The fill field is required.",
            onPressed: () => Get.back());
      } else {
        isLoading.value = true;
        isButton.value = true;
        var prefs = await SharedPreferences.getInstance();
        var id = prefs.getString('UserId');
        var authKey = prefs.getString('AuthKey');

        Map<String, String> headers = {'Authorization': 'Bearer $authKey'};
        var request =
            http.MultipartRequest('POST', Uri.parse(AppUrl.addComment));

        request.fields.addAll({
          'user_id': id!,
          'description': htmlText,
          'status_id': statusId,
          'task_id': taskId,
        });

        request.headers.addAll(headers);

        if (images.isNotEmpty) {
          for (var imagePath in images) {
            if (kDebugMode) {
              print('imagePath');
              print(imagePath);
            }

            request.files.add(await http.MultipartFile.fromPath(
                'attachments[]', imagePath.path));
          }
        }
        if (kDebugMode) {
          print('request.files');
          print(request.files);
        }

        http.StreamedResponse response = await request.send();
        final res = await http.Response.fromStream(response);
        if (kDebugMode) {
          print('res.body');
          print(res.body);
        }
        Map<String, dynamic> data =
            json.decode(res.body) as Map<String, dynamic>;
        String responseBody = await response.stream.bytesToString();
        if (kDebugMode) {
          print(responseBody);
        }
        Get.back();
        if (data['common']['user_login'] == false) {
          isButton.value = false;
          prefs.clear();
          Get.offAll(const SplashScreen());
        }
        if (data['common']['status'] == true) {
          isButton.value = false;
          images.clear();
          showStatusPopup(
            title: "Task Updated Successfully",
            content: data['common']['message'],
            isSuccess: true,
            onPressed: () => Get.offAllNamed('mainPage'),
          );

        } else {
          isButton.value = false;
          showStatusPopup(
            title: "Error",
            content: "occurring_error",
            isSuccess: false,
            onPressed: () => Get.offAllNamed('mainPage'),
          );
        }
      }
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
      isButton.value = false;
      Get.back();
      if (statusId.isNotEmpty && htmlText.isNotEmpty) {
        images.clear();
        showStatusPopup(
          title: "Task Updated Successfully",
          isSuccess: true,
          content: "Your task has been Updated successfully.",
          onPressed: () => Get.toNamed("taskDetails", arguments: {
            'taskId': taskId,
          }),
        );
      } else {
        showStatusPopup(
            title: "error",
            content: "please_enter_fill_required_value",
            onPressed: () => Get.back());
      }
    } finally {
      isLoading.value = false; // End loading state
    }
  }
}
