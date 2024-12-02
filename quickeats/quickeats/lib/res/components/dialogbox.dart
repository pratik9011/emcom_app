import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'components_list.dart'
    show
        AlertDialog,
        AppColors,
        AssetImage,
        Border,
        BorderRadius,
        BorderSide,
        BoxDecoration,
        BoxShadow,
        BuildContext,
        Card,
        Center,
        CircularProgressIndicator,
        Color,
        ColorScheme,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        DashboardController,
        DecorationImage,
        Dialog,
        DropDownInput,
        DropDownInputPopup,
        EdgeInsets,
        FontWeight,
        Get,
        Icon,
        Icons,
        Image,
        InkWell,
        InputDecoration,
        MainAxisAlignment,
        OutlineInputBorder,
        Padding,
        Row,
        Scaffold,
        Shimmer,
        SizedBox,
        StatelessWidget,
        StatusListController,
        Text,
        TextAlign,
        TextButton,
        TextButtonThemeData,
        TextField,
        TextStyle,
        Theme,
        Widget,
        buildRoundButton,
        heightSize,
        heightSpaceBox,
        kDebugMode,
        rowTextLine,
        showDatePicker,
        TextLine,
        translate,
        widthSpaceBox;

Future errorShowDialog(
        {required String title,
        required String content,
        bool isSuccess = false,
        onPressed}) =>
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            translate(title),
            style: const TextStyle(
              fontSize: 18,
            ),
          )),
          content: SizedBox(
            height: heightSize(100),
            child: Column(
              children: [
                isSuccess
                    ? const Icon(
                        Icons.check_circle,
                        color: AppColors.buttonColor,
                        size: 50,
                      )
                    : const Icon(
                        Icons.warning,
                        color: AppColors.red,
                        size: 50,
                      ),
                TextLine(title: content, lines: 3, fontSize: 12),
              ],
            ),
          ),
          actions: [
            buildRoundButton(
                width: double.infinity,
                height: 50,
                title: 'ok',
                onPressed: onPressed)
          ],
        ));

Future showFilterDialog(dynamic data, BuildContext context) {
  final status = Get.find<StatusListController>();
  final data = Get.find<DashboardController>();
  String? formattedDate;
  String? statusId;
  // Get.find<TaskDetailsController>();
  status.getStatusApi();
  return Get.dialog(
      barrierColor: Colors.transparent.withOpacity(0.3),
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: Colors.white,
        title: Obx(
          () => status.isLoading.isTrue
              ? const SizedBox(height: 60, child: TextFieldSkeleton())
              : DropDownInputPopup(
                  selectItems: status.statusList,
                  labelText: 'Select_status',
                  onChanged: (value) {
                    statusId = value;
                  },
                ),
        ),
        content: Obx(() => status.isLoading.isTrue
            ? const SizedBox(height: 60, child: TextFieldSkeleton())
            : TextField(
                style: const TextStyle(color: Colors.black),
                // controller: fromDate,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  prefixIcon: const Icon(
                    Icons.calendar_month,
                    color: Colors.grey,
                  ),
                  // filled: true,
                  // fillColor: Color(0xFF121212),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.black),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.black,
                      width: 1.0,
                    ),
                  ),
                  //icon of text field
                  hintText: 'From',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime now = DateTime.now();
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: DateTime(2024, 01, 01),
                    lastDate: now,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    if (kDebugMode) {
                      print(formattedDate);
                    }
                  } else {}
                },
              )),
        actions: [
          buildRoundButton(
              width: double.infinity,
              height: 50,
              title: "search",
              onPressed: () {
                Get.back();
                data.getTaskListStatusDateApi(
                  statusId: statusId ?? '',
                  date: formattedDate ?? '',
                );
              }),
          heightSpaceBox(size: 10),
          buildRoundButton(
              width: double.infinity,
              height: 50,
              title: "cancel",
              foregroundColor: AppColors.black,
              backgroundColor: Colors.white,
              onPressed: () => Get.back())
        ],
      ));
}

Future showAllDetails(
  dynamic data,
) =>
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(translate(data['code'] ?? '')),
              InkWell(onTap: () => Get.back(), child: const Icon(Icons.close))
            ],
          ),
          content: SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    rowTextLine(
                        title: "Department:",
                        fontSize: 15,
                        isBold: false,
                        textWidth: 100),
                    widthSpaceBox(size: 10),
                    rowTextLine(
                        title: data['department'] ?? '',
                        fontSize: 15,
                        lines: 2,
                        isBold: true,
                        textWidth: 100),
                  ],
                ),
                heightSpaceBox(size: 10),
                Row(
                  children: [
                    rowTextLine(
                        title: "Status:",
                        fontSize: 15,
                        isBold: false,
                        textWidth: 100),
                    widthSpaceBox(size: 10),
                    data['status_color']==''? const SizedBox():Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color(int.parse(data['status_color']))),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: TextLine(
                            title: data['status'] ?? '',
                            fontSize: 13,
                            color: Color(int.parse(data['status_color']))),
                      ),
                    )
                  ],
                ),
                heightSpaceBox(size: 10),
                Row(
                  children: [
                    rowTextLine(
                        title: "Created On:",
                        fontSize: 15,
                        isBold: false,
                        textWidth: 100),
                    widthSpaceBox(size: 10),
                    rowTextLine(
                        title: data['created_on'] ?? "",
                        fontSize: 15,
                        lines: 2,
                        isBold: true,
                        textWidth: 100),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.toNamed('/addComment', arguments: {
                      "taskId": data['id'] ?? '',
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.edit_outlined,
                            color: AppColors.white,
                          ),
                          widthSpaceBox(size: 5),
                          TextLine(
                              title: 'edit',
                              fontSize: 13,
                              isBold: true,
                              color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.toNamed('/taskDetails', arguments: {
                      "taskId": data['id'] ?? '',
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.redAccent),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye,
                            color: AppColors.white,
                          ),
                          widthSpaceBox(size: 5),
                          TextLine(
                              title: 'view',
                              fontSize: 13,
                              isBold: true,
                              color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));

Future showDialogYesNo(
        {required String title,
        required String content,
        String btnTitle = 'yes',
        onPressed}) =>
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: Colors.white,
        title: TextLine(title: title, fontSize: 20, isBold: true),
        content: TextLine(
          title: content,
          fontSize: 15,
          lines: 3,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildRoundButton(
                  width: 110,
                  height: 40,
                  title: btnTitle,
                  onPressed: onPressed ?? () {},
                  backgroundColor: AppColors.buttonColor,
                  foregroundColor: AppColors.white),
              widthSpaceBox(size: 10),
              buildRoundButton(
                  width: 110,
                  height: 40,
                  title: "no",
                  onPressed: () {
                    Get.back();
                  },
                  backgroundColor: AppColors.buttonColor,
                  foregroundColor: AppColors.white),
            ],
          ),
        ],
      ),
    );

Future showDialogYesNoWithImage(
        {required String title,
        required String content,
        String btnTitle = 'yes',
        required String image,
        onPressed}) =>
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          title: Image.asset(
            image,
            height: 100,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextLine(title: title, fontSize: 18, isBold: true),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: TextLine(title: content, fontSize: 12, lines: 1)),
            ),
            Center(
              child: buildRoundButton(
                width: 700,
                height: 50,
                title: translate(btnTitle),
                backgroundColor: AppColors.buttonColor,
                foregroundColor: AppColors.white,
                onPressed: onPressed ?? () {},
              ),
            ),
            Center(
                child: TextButton(
                    onPressed: () => Get.back(),
                    child:
                        TextLine(title: "cancel", fontSize: 15, isBold: true))),
          ],
        ));

void showStatusPopup({
  required String title,
  required String content,
  bool isSuccess = false,
  onPressed,
  int seconds = 2,
}) {
  Get.dialog(AlertDialog(
    backgroundColor: Colors.white,
    title: Center(
        child: Text(
      translate(title),
      textAlign: TextAlign.center,
    )),
    content: SizedBox(
      height: heightSize(100),
      child: Column(
        children: [
          isSuccess
              ? const Icon(
                  Icons.check_circle,
                  color: AppColors.buttonColor,
                  size: 60,
                )
              : const Icon(
                  Icons.warning,
                  color: AppColors.red,
                  size: 60,
                ),
          TextLine(title: content, fontSize: 13, lines: 3),
        ],
      ),
    ),
  ));
  Future.delayed(Duration(seconds: seconds), onPressed);
}

void showApiProgressPopup(
    {required String title,
    required String content,
    bool isSuccess = false,
    onPressed,
    int seconds = 2,
    bool isLoading = false}) {
  Get.dialog(AlertDialog(
    title: Center(child: Text(translate(title))),
    content: SizedBox(
      height: heightSize(100),
      child: Column(
        children: [
          Obx(
            () => isLoading
                ? const CircularProgressIndicator()
                : isSuccess
                    ? const Icon(
                        Icons.check_circle,
                        color: AppColors.green,
                        size: 60,
                      )
                    : const Icon(
                        Icons.warning,
                        color: AppColors.red,
                        size: 60,
                      ),
          ),
          TextLine(title: content, fontSize: 13, lines: 3),
        ],
      ),
    ),
  ));
  Future.delayed(Duration(seconds: seconds), onPressed);
}

class TextFieldSkeleton extends StatelessWidget {
  const TextFieldSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
              )
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                // border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future statusClick(
    {required String title,
    required String content,
    String btnTitle = 'ok',
    bool isSuccess = false,
    onPressed}) {
  final status = Get.find<StatusListController>();
  status.getStatusApi();
  return Get.dialog(
    barrierDismissible: false,
    Dialog(
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/01-01.png")),
              ),
            ),
            Text(
              translate(title),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              translate(title),
              style:
                  const TextStyle(fontSize: 12, color: AppColors.blackShade9),
            ),
            Obx(
              () => status.isLoading.isTrue
                  ? const SizedBox(height: 60, child: TextFieldSkeleton())
                  : DropDownInput(
                      selectItems: status.statusList,
                      labelText: 'Select_status',
                    ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildRoundButton(
                      width: 100,
                      height: 40,
                      title: "cancel",
                      onPressed: () => Get.back()),
                  buildRoundButton(
                      width: 100,
                      height: 40,
                      title: btnTitle,
                      onPressed: onPressed)
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
