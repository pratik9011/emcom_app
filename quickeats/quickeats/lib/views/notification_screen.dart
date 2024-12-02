import 'package:get/get.dart' show Get, GetNavigation, Inst, Obx, RxBoolExt;

import 'view_list.dart'
    show AppBar, AppColors, AssetImage, BuildContext, Card, Center, CircleAvatar, Color, Colors, Column, CrossAxisAlignment, DashboardController, Divider, EdgeInsets, FontWeight, Get, Image, InkWell, ListView, MainAxisAlignment, NetworkImage, NeverScrollableScrollPhysics, NotificationController, Padding, Row, Scaffold, SingleChildScrollView, SizedBox, State, StatefulWidget, StatelessWidget, Text, TextStyle, Widget, heightSpaceBox, taskSkl, TextLine;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final data = Get.put(NotificationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data.firstLoad();
    data.controllerSingle.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (data.controllerSingle.position.pixels ==
        data.controllerSingle.position.maxScrollExtent) {
      data.loadMore();
    }
  }

  @override
  void dispose() {
    Get.delete<NotificationController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: TextLine(title: "notification", fontSize: 17, isBold: true),
      ),
      body: SingleChildScrollView(
        controller: data.controllerSingle,
        child: Column(
          children: [
            Obx(
                  () =>
              data.isLoading.isTrue
                  ? const SizedBox()
                  : data.notificationList.length == 0
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty-data.png',
                    height: 200,
                  ),
                  const Center(
                    child: Text(
                      "No Data Found",
                      style:
                      TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              )
                  : SizedBox(
                height: data.notificationList.length * 180.0,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.notificationList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        InkWell(
                          onTap: () {
                            data.getReadNotification(notificationId: data.notificationList[index]['id']);
                            Get.toNamed(
                                data.notificationList[index]
                                ['action'] ??
                                    "serverMaintenancePage",
                                arguments: {
                                  'taskId': data.notificationList[index]
                                  ['data']['id']
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color:data.notificationList[index]['is_read']=='0'?Colors.grey.shade300:Colors.grey.shade100,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        // CircleAvatar(
                                        //   radius: 20,
                                        //   backgroundColor: Colors.white,
                                        //   backgroundImage:
                                          // data.notificationList[
                                          // index]
                                          // ['image'] ==
                                          //     ''
                                          //     ? const AssetImage(
                                          //     'assets/images/Notification-water-mark.png')
                                          //     : NetworkImage(
                                          //   data.notificationList[
                                          //   index]
                                          //   ['image'] ?? "",
                                          // ),
                                        // ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: TextLine(
                                                  title: data.notificationList[
                                                  index]
                                                  ['title'] ??
                                                      '',
                                                  fontSize: 15,
                                                  isBold: true,
                                                  color: AppColors
                                                      .black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: TextLine(
                                        title: data.notificationList[
                                        index]['body'] ??
                                            '',
                                        lines: 3,
                                        fontSize: 13,
                                        isBold: false,
                                        color: AppColors.black),
                                  ),
                                  heightSpaceBox(size: 10),
                                ],
                              ),
                            ),
                          ),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
