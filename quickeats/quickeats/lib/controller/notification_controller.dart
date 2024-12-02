import 'controller_list.dart'
    show
        AppUrl,
        Get,
        ScrollController,
        SharedPreferences,
        apiServices,
        checkLogin,
        errorShowDialog,
        json,
        kDebugMode;
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  var isLoading = true.obs;
  var dataNull = true.obs;

  // final notificationList = [].obs;
  final upData = {}.obs;
  RxList notificationList = [].obs;
  final ScrollController controller = ScrollController();
  final ScrollController controllerSingle = ScrollController();
  final hasNextPage = true.obs;
  final isFirstLoadRunning = false.obs;
  final isLoadMoreRunning = false.obs;
  final page = 0.obs;

  // RxString statusId = ''.obs;

  getNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('UserId').toString();
    final data2 = await apiServices.postApi(
        AppUrl.getNotification,
        {
          'user_id': userId,
        },
        isData: true,
        isToken: true);
    if (data2.isSuccess == true) {
      isLoading.value = false;
      notificationList.value = data2.data;

      if (kDebugMode) {
        print('working');
        print(notificationList.length);
      }
    } else {
      isLoading.value = false;
      errorShowDialog(
          title: "data", content: data2.message, onPressed: () => Get.back());
    }
  }

  void firstLoad() async {
    isFirstLoadRunning.value = true;
    notificationList.clear();
    page.value = 0;
    try {
      var prefs = await SharedPreferences.getInstance();
      var id = prefs.getString('UserId');
      var authKey = prefs.getString('AuthKey');
      http.Response response = (await http.post(
        Uri.parse(AppUrl.getNotification),
        headers: {
          'Authorization': 'Bearer $authKey',
        },
        body: {
          'user_id': id,
          'page_no': page.toString(),
        },
      ));
      Map<String, dynamic> res =
          json.decode(response.body) as Map<String, dynamic>;

      if (res['common']['status'] == true) {
        if (kDebugMode) {
          print('working');
        }
        notificationList.value = res['data'];
        isLoading.value = false;
        // taskList.value = res['data'];
      } else {
        if (kDebugMode) {
          print('working1');
        }
        isLoading.value = false;
        // notificationList.value = [];
      }

      hasNextPage.value = res['data'].length >= 12;
      isFirstLoadRunning.value = false;
      if (kDebugMode) {
        print('working2');
      }
      checkLogin(
        status: res['common']['status'],
        message: res['common']['message'],
      );
    } catch (err) {
      if (kDebugMode) {}
      isLoading.value = false;
    }
    isFirstLoadRunning.value = false;
    isLoading.value = false;
  }

  void loadMore() async {
    if (isFirstLoadRunning.value == false && isLoadMoreRunning.value == false) {
      page.value += 1;
      try {
        isLoadMoreRunning.value = true;
        if (kDebugMode) {
          print(isFirstLoadRunning);
        }
        var prefs = await SharedPreferences.getInstance();
        var id = prefs.getString('UserId');
        var authKey = prefs.getString('AuthKey');
        if (kDebugMode) {
          print(page);
        }
        http.Response response = (await http.post(
          Uri.parse(AppUrl.readNotification),
          headers: {
            'Authorization': 'Bearer $authKey',
          },
          body: {
            'user_id': id,
            'page_no': page.toString(),
          },
        ));
        Map<String, dynamic> res =
            json.decode(response.body) as Map<String, dynamic>;

        List fetchedPosts = res['data']['task_list'];
        if (res['common']['status'] == true) {
          if (notificationList == null) {
            // data['task_list'] = [];
          }
          notificationList.addAll(fetchedPosts);
          if (kDebugMode) {
            print(notificationList);
            print(notificationList.length);
          }

          hasNextPage.value = fetchedPosts.length >= 12;
        } else {
          hasNextPage.value = false;
        }
      } catch (err) {
        if (kDebugMode) {}
      }
      isLoadMoreRunning.value = false;
    }
  }

  getReadNotification({required String notificationId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('UserId').toString();
    final data2 = await apiServices.postApi(
        AppUrl.readNotification,
        {
          'user_id': userId,
          'notification_id': notificationId,
        },
        isData: false,
        isToken: true);
    if (data2.isSuccess == true) {
        print('read_successfully');
       getNotification();
    } else {

    }
  }
}
