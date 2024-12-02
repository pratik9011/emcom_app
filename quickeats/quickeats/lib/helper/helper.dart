import 'dart:async' show Future;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart'
    show InternetConnectionChecker;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:package_info_plus/package_info_plus.dart';
import '../config.dart'
    show
        AlertDialog,
        Alignment,
        AppColors,
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Card,
        Center,
        Color,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        Dialog,
        Divider,
        EdgeInsets,
        FontWeight,
        Get,
        Icon,
        Icons,
        Image,
        InkWell,
        LaunchMode,
        LoginScreen,
        MainAxisAlignment,
        MainAxisSize,
        Padding,
        PopScope,
        Radius,
        Row,
        SharedPreferences,
        SizedBox,
        SplashScreen,
        StatelessWidget,
        Text,
        TextStyle,
        Widget,
        buildRoundButton,
        canLaunchUrl,
        heightSize,
        kDebugMode,
        launchUrl,
        TextLine,
        widthSize;

Future<void> checkInternetAndShowPopup() async {
  bool result = await InternetConnectionChecker().hasConnection;

  var prefs = await SharedPreferences.getInstance();
  if (result == false) {
    Get.dialog(
        barrierDismissible: false,
        Dialog(
          backgroundColor: AppColors.white,
          child: PopScope(
            canPop: false,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: TextLine(
                        title: "No Internet Connection",
                        fontSize: 20,
                        isBold: true,
                        color: AppColors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/icon/connection.png",
                    height: heightSize(100),
                    color: AppColors.buttonColor,
                  ),
                  Center(
                    child: TextLine(
                      title:
                          "Please check your connection again,or connect to wi-fi.",
                      fontSize: 12,
                      lines: 2,
                    ),
                  ),
                  const Divider(
                    color: AppColors.grey,
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      prefs.clear();
                      Get.to(() => const SplashScreen());
                    },
                    child: Center(
                      child: Container(
                        height: heightSize(40),
                        width: widthSize(200),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: AppColors.buttonColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextLine(
                            title: "refresh",
                            fontSize: 15,
                            isBold: true,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  } else {
    null;
  }
}

class DownloadButton extends StatelessWidget {
  final String url;

  const DownloadButton({super.key, required this.url});

  Future<void> launchData() async {
    final Uri url2 = Uri.parse(url);
    if (await canLaunchUrl(url2)) {
      await launchUrl(url2, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchData(),
      child: const Card(
        color: Colors.redAccent,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.download,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

dateLive() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MMM dd, yyyy').format(now);
  return formattedDate;
}

String fileTypeChecker(String fileType) {
  String primaryType = fileType.split('/')[0];
  return primaryType;
}

Widget checkTypeManger({
  required String fileType,
  required String filePath,
  required String taskId,
}) {
  if ('image' == fileTypeChecker(fileType)) {
    if (fileType == "image/svg+xml") {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.grey),
        ),
        child: Center(
          child: Stack(
            children: [
              SvgPicture.network(
                filePath,
                width: 30,
                height: 30,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.grey),
          image: DecorationImage(
            image: NetworkImage(filePath),
          ),
        ),
      );
    }
  } else if ('video' == fileTypeChecker(fileType)) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.grey),
        image: const DecorationImage(
          image: AssetImage(
            'assets/icon/video-icon.png',
          ),
        ),
      ),
    );
  } else if ('application' == fileTypeChecker(fileType)) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.grey),
        image: const DecorationImage(
          image: AssetImage(
            'assets/icon/google-docs.png',
          ),
        ),
      ),
    );
  } else {
    return TextLine(title: 'unsupported_file_type', lines: 3, fontSize: 10);
  }
}

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

Future<bool> versionChecker({required String version}) async {
  bool status = false;
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version1 = packageInfo.version;
  String version2 = "2.0.0";

  if (compareVersions(version1, version2) > 0) {
    status = false;
  } else {
    status = true;
  }
  return status;
}

int compareVersions(String v1, String v2) {
  List<String> v1Parts = v1.split('.');
  List<String> v2Parts = v2.split('.');

  for (int i = 0; i < 3; i++) {
    int v1Part = int.parse(v1Parts[i]);
    int v2Part = int.parse(v2Parts[i]);

    if (v1Part > v2Part) return 1;
    if (v1Part < v2Part) return -1;
  }
  return 0; // Versions are equal
}

Future<void> showUpdateDialog(var data) async {
  if (versionChecker(version: data['version']) == true) {
    if (data['show_popup'] == true) {
      Get.dialog(
        AlertDialog(
          title: const Text('Update App'),
          content: const Text(
              'Enjoy improved performance and new features designed just for you!'),
          actions: [
            Row(
              mainAxisAlignment: data['force_update'] == false
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                const SizedBox(),
                data['force_update'] == false
                    ? InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Text(
                          "No Thanks",
                          style: TextStyle(
                              color: Color(0xff01875f),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : const SizedBox(),
                buildRoundButton(
                  width: data['force_update'] == false ? 100 : 200,
                  height: 40,
                  title: "Update",
                  onPressed: () async {
                    if (!await launchUrl(
                      Uri.parse(data['url']),
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw Exception('Could not launch ${data['url']}');
                    }
                  },
                  backgroundColor: const Color(0xff01875f),
                  foregroundColor: Colors.white,
                ),
              ],
            ),
            const Divider(),
          ],
        ),
        barrierDismissible: false,
      );

      // Automatically close the dialog after 1 second
      Future.delayed(const Duration(seconds: 1), () {
        if (data['show_popup'] == false) {
          if (kDebugMode) {
            print('Closing dialog after 1 second');
          }
          Get.back();
        }
      });
    }
  }
}

void checkLogin({
  required bool status,
  required String message,
}) async {
  if (status == false) {
    if (message == "Invalid App Security Key" || message == "Invalid Request") {
      Get.snackbar(
        'Logged Out',
        "Your account is logged in on another device. You have been logged out.",
        colorText: Colors.black,
        icon: const Icon(Icons.add_alert),
      );
      var prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Get.offAll(() => const LoginScreen());
    }
  }
}


void lunchCall({required String number}) async{
  final call = Uri.parse(
      'tel:+91 $number');
  if (await canLaunchUrl(call)) {
    launchUrl(call);
  } else {
    throw 'Could not launch $call';
  }
}