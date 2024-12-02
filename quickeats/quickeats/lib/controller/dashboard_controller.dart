import 'dart:developer';

import 'controller_list.dart'
    show
        AppUrl,
        Get,
        ProfileController,
        ScrollController,
        SharedPreferences,
        SplashScreen,
        WidgetsBinding,
        apiServices,
        checkLogin,
        errorShowDialog,
        json,
        kDebugMode,
        showUpdateDialog;
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  var isLoading = true.obs;
  var dataNull = true.obs;
  final data = {}.obs;
  final notificationList = [].obs;
  final upData = {}.obs;
  RxList taskList = [].obs;
  RxList taskList1 = [].obs;
  final ScrollController controller = ScrollController();
  final ScrollController controllerSingle = ScrollController();
  final hasNextPage = true.obs;
  final isFirstLoadRunning = false.obs;
  final isLoadMoreRunning = false.obs;
  final page = 0.obs;

  // RxString statusId = ''.obs;

  @override
  void onInit() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getDashboardApi();
      Get.put(ProfileController()).getProfileApi();
    });
    super.onInit();
  }

  getDashboardApi() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      isLoading.value = true;
      var userId = prefs.getString('UserId').toString();
      var authKey = prefs.getString('AuthKey').toString();

      isLoading(true);
      http.Response response = (await http.post(
        Uri.parse(AppUrl.getDashBoard),
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
        isLoading.value = false;
        data.value = res['data'];
        taskList.value = res['data']['task_list'];
        upData.value = res['android'];
        Get.back();
        Get.back();
        // showUpdateDialog(upData);
      } else if (res['common']['status'] == false) {
      } else if (res.isEmpty) {
        // showStatusPopup(
        //     title: 'data_not_found',
        //     content: 'data_not_found_back_to_home',
        //     onPressed: () => Get.offAllNamed('serverMaintenancePage'));
      }
    } finally {
      isLoading(false);
    }
  }

  get2DashboardApi() async {
    isLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('UserId').toString();
    final data2 = await apiServices.postApi(
        AppUrl.getDashBoard,
        {
          'user_id': userId,
        },
        isData: true,
        isToken: true);
    if (data2.isSuccess == true) {
      isLoading.value = false;
      data.value = data2.data;
      taskList.value = data2.data['task_list'];
    } else {
      isLoading.value = false;
    }
  }

  getTaskListStatusDateApi({String date = '', String statusId = ""}) async {
    isLoading.value = true;
    taskList.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('UserId').toString();
    log('date: $date');
    taskList.clear();
    final data2 = await apiServices.postApi(
        AppUrl.getTaskList,
        {
          'user_id': userId,
          'status_id': statusId,
          'dates': date,
        },
        isData: true,
        isToken: true);
    log(data2.isSuccess.toString());
    if (data2.isSuccess == true) {
      isLoading.value = false;
      data.value = data2.data;
      taskList.value = data2.data['task_list'];
      log(data2.data['task_list'].length.toString());
    } else {
      isLoading.value = false;
      data.clear();
    }
  }

  getShowTask({String statusId = ""}) async {
    isLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('UserId').toString();

    taskList.clear();
    final data2 = await apiServices.postApi(
        AppUrl.getTaskList,
        {
          'user_id': userId,
          'status_id': statusId,
        },
        isData: true,
        isToken: true);
    log(data2.isSuccess.toString());
    if (data2.isSuccess == true) {
      isLoading.value = false;
      data.value = data2.data;
      taskList1.value = data2.data['task_list'];
      log(data2.data['task_list'].length.toString());
    } else {
      isLoading.value = false;
      data.clear();
    }
  }

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
    isLoading.value = true;
    data.clear();
    page.value = 0;
    try {
      var prefs = await SharedPreferences.getInstance();
      var id = prefs.getString('UserId');
      var authKey = prefs.getString('AuthKey');
      http.Response response = (await http.post(
        Uri.parse(AppUrl.getTaskList),
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
        isLoading.value = false;
        data.value = res['data'];
        taskList.value = res['data']['task_list'];
      } else {
        isLoading.value = false;
        data.value = {};
      }

      hasNextPage.value = res['data'].length >= 12;
      isFirstLoadRunning.value = false;
      isLoading.value = false;
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
          Uri.parse(AppUrl.getTaskList),
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
          if (data['task_list'] == null) {
            // data['task_list'] = [];
          }
          taskList.addAll(fetchedPosts);
          if (kDebugMode) {
            print(data['task_list']);
            print(data['task_list'].length);
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
}
