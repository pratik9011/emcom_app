import 'package:get/get.dart';
import '../../config.dart';

Widget taskDetailsContainer({required String taskId}){
  final data = Get.find<TaskDetailsController>();
  data.getTaskDetailsApi(taskId: taskId.toString());
  return SliverToBoxAdapter(
      child: Obx(
            () => data.isLoading.isTrue
            ? const SizedBox()
            : Padding(
          padding:
          const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Container(
            color: Colors.white,
            height: 250,
            child: ListView.builder(
                itemCount: data.data['attachments'].length ?? 0,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      checkTypeManger(

                        fileType: data.data['attachments'][index]
                        ['type']
                            .toString(),
                        filePath: data.data['attachments'][index]
                        ['path']
                            .toString(),
                        taskId: taskId,
                      ),
                      Obx(
                            () => data.isLoading.isTrue
                            ? const SizedBox()
                            : DownloadButton(
                          url: data.data['attachments'][index]
                          ['path'] ??
                              "",
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ));
}