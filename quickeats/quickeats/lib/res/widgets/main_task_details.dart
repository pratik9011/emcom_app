import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../config.dart';

Widget mainTaskDetails({required String taskId}){
  final data = Get.find<TaskDetailsController>();
  data.getTaskDetailsApi(taskId: taskId.toString());
  return SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                    () => data.isLoading.isTrue
                    ? const SizedBox()
                    : TextLine(
                    title: data.data['code'].toString(),
                    fontSize: 17,
                    isBold: true),
              )),
          const Divider(
            color: AppColors.grey,
          ),
          Obx(() => data.isLoading.isTrue
              ? const CircularProgressIndicator()
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(data.data['description'] ?? ''),
          )),
        ],
      ),
    ),
  ),
);}