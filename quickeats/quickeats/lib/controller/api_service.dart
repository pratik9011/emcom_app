import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;
import 'package:quickeats/res/components/print.dart';
import 'controller_list.dart'
    show
        Get,
        HttpException,
        NetworkIssue,
        ServerMaintenanceScreen,
        SharedPreferences,
        SocketException,
        SplashScreen,
        json;

class ApiServices {
  Future<APIDataClass> postApi(String apiName, Map<String, dynamic> body,
      {bool isToken = false, bool isData = false}) async {
    APIDataClass apiData = APIDataClass(
      message: 'No data',
      isSuccess: false,
      data: '0',
    );
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      apiData.message = "No Internet Access";
      apiData.isSuccess = false;
      apiData.data = 0;
      Get.offAll(() => const NetworkIssue());
      return apiData;
    } else {
      log("URL: $apiName");

      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('auth_key');
      // String? userId = pref.getString('AuthKey');
      log("AUTH : $token");
      String? header = isToken ? token : 'demo';
      try {
        http.Response response = await http
            .post(
              Uri.parse(apiName),
              headers: {
                'Authorization': 'Bearer $header',
              },
              body: body,
            )
            .timeout(const Duration(seconds: 30));

        Map<String, dynamic> responseData = json.decode(response.body);

        if (response.statusCode == 200) {
          log('statusCode: 200');
          if (isToken == false) {
            if (apiName.contains("login") ||
                apiName.contains("send-otp") ||
                apiName.contains("verify-otp") ||
                apiName.contains("register")) {
              pref.clear();
              if (apiName.contains("send-otp")) {
                if (apiName.contains("login")) {
                  pref.setString(
                      "UserId", responseData['user']['id'].toString());
                  pref.setString("AuthKey",
                      responseData['user']['app_auth_key'].toString());
                }
                apiData.message = responseData['common']['message'];
                apiData.isSuccess = responseData['common']['status'];
              } else if (apiName.contains("verify-otp")) {
                if (responseData['data']['status'] == true) {
                  if (responseData['data']['is_user_exist'] == true) {
                    pref.clear();
                    pref.setString("UserId", responseData['user']['id']);
                    pref.setString("AuthKey", responseData['user']['app_auth_key']);


                    printTest('userId');
                    printTest(pref.getString("UserId"));
                    printTest('AuthKey');
                    printTest(pref.getString("AuthKey"));


                    apiData.message = responseData['common']['message'];
                    apiData.isSuccess = responseData['common']['status'];
                    // return apiData;
                  } else {
                    printTest('not Working');
                    apiData.message = responseData['common']['message'];
                    apiData.isSuccess = responseData['common']['status'];
                  }
                } else {
                  apiData.message = responseData['common']['message'];
                  apiData.isSuccess = responseData['common']['status'];
                  // return apiData;
                }
              } else if (apiName.contains("register")) {
                if (responseData['common']['status'] == true) {
                  pref.setString("UserId", responseData['user']['id']);
                  pref.setString(
                      "AuthKey", responseData['user']['app_auth_key']);
                  apiData.message = responseData['common']['message'];
                  apiData.isSuccess = responseData['common']['status'];
                } else {
                  apiData.message = responseData['common']['message'];
                  apiData.isSuccess = responseData['common']['status'];
                  // return apiData;
                }
              }

              // log("Response: ${response.body}");
              // apiData.message =
              //     apiName.contains("login") || apiName.contains("social/login")
              //         ? "Login Successfully"
              //         : "Register Successfully";
              // apiData.isSuccess = true;
              // apiData.data = responseData;
              // return apiData;
            }
            // return apiData;
          }
          if (responseData['common']['status'] == true) {
            if (isData) {
              if (isToken == true) {
                if (responseData['common']['user_login'] == false) {
                  pref.clear();
                  Get.offAll(const SplashScreen());
                }
              }

              apiData.message = responseData['common']["message"] ?? "";
              apiData.isSuccess = true;
              apiData.data = responseData['data'];
            } else {
              apiData.message = responseData['common']["message"] ?? "";
              apiData.isSuccess = true;
              apiData.data = 0;
            }
            return apiData;
          }
        } else {
          log("Response error: ${response.body}");
          apiData.message =
              responseData['common']["message"] ?? "Unknown Error";
          apiData.isSuccess = false;
          apiData.data = 0;
          return apiData;
        }
        return apiData;
      } on SocketException {
        log("No Internet Connection");
        apiData.message = "No Internet Connection";
        apiData.isSuccess = false;
        Get.offAll(() => const NetworkIssue());
        apiData.data = 0;
        return apiData;
      } on HttpException {
        log("Server returned invalid response");
        apiData.message = "Server returned invalid response";
        apiData.isSuccess = false;
        Get.to(() => const ServerMaintenanceScreen());
        apiData.data = 0;
        return apiData;
      } on TimeoutException {
        log("Request Timeout");
        apiData.message = "Request Timeout";
        apiData.isSuccess = false;
        apiData.data = 0;
        Get.to(() => const NetworkIssue());
        return apiData;
      } catch (e) {
        log("Unexpected Error: $e");
        apiData.message = "An unexpected error occurred: $e";
        apiData.isSuccess = false;
        apiData.data = 0;
        return apiData;
      }
    }
  }
}

class APIDataClass {
  String message;
  bool? isSuccess;
  dynamic data;

  APIDataClass({this.message = "", this.isSuccess, this.data});

  factory APIDataClass.fromJson(Map<String, dynamic> json) {
    return APIDataClass(
        message: json['message'] as String,
        isSuccess: json['isSuccess'] as bool,
        data: json['data'] as dynamic);
  }
}
