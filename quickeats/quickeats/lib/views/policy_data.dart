import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'view_list.dart';



class PolicyData extends GetView<GetPolicyController> {
  final String slug;

  const PolicyData({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPolicy(slug: slug);
    });
    return
    //   Scaffold(
    //   appBar: AppBar(
    //     surfaceTintColor: Colors.white,
    //     backgroundColor: Colors.white,
    //     titleSpacing: 0,
    //     title: Text(
    //       widget.slug.toString(),
    //       style: const TextStyle(
    //           fontSize: Sizes.TEXT_SIZE_22,
    //           fontWeight: FontWeight.bold),
    //     ),
    //   ),
    // );

      Obx(
      () => controller.isFirstLoadRunning.isTrue
          ? Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                titleSpacing: 0,
                title: Text(
                  controller.privacyData[0]['page_name'] ?? '',
                  style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // body: InAppWebView(
              //   initialUrlRequest: URLRequest(
              //       // url: WebUri('${controller.privacyData['url']}?key=demo')),
              //       url: WebUri('https://khamgaon.deepmindsit.com/api/V1/page-webview/legal/privacy-policy?key=demo')),
              //   initialSettings: InAppWebViewSettings(
              //     pageZoom: 8,
              //     supportZoom: true,
              //     minimumFontSize: 8,
              //     javaScriptEnabled: true,
              //   ),
              //   onPermissionRequest: (controller, request) async {
              //     return PermissionResponse(
              //         resources: request.resources,
              //         action: PermissionResponseAction.GRANT);
              //   },
              // ),

              // ListView(
              //   children: [
              //     SizedBox(
              //     width: Get.width,
              //     child: HtmlWidget(
              //         controller.privacyData['page_description'])),
              //   ],
              // ),
            ),
    );
  }
}
