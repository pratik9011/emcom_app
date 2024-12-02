import 'package:get/get.dart';

import 'widgetList.dart'
    show
        AppColors,
        Axis,
        Border,
        BorderRadius,
        BoxDecoration,
        BuildContext,
        ClampingScrollPhysics,
        Column,
        Container,
        DecorationImage,
        EdgeInsets,
        GestureDetector,
        Get,
        ListView,
        NetworkImage,
        Padding,
        Radius,
        SizeConfig,
        SizedBox,
        StatelessWidget,
        SubCategoryController,
        SubService,
        TextLine,
        Widget;

class SubCategoryHorizontalWidget extends StatelessWidget {
  const SubCategoryHorizontalWidget({super.key,required this.categoryId});
   final String categoryId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubCategoryController());
    controller.subCategoryApi(categoryId: categoryId);
    return Obx(
      () => controller.isLoading.isTrue
          ? const SizedBox()
          : SizedBox(
              height: SizeConfig.blockSizeVertical = 90,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.subCategoryList.length,
                itemBuilder: (BuildContext context, int index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => SubService(
                                categoryId:
                                    controller.subCategoryList[index]['id'],
                                categoryName: controller.subCategoryList[index]
                                    ['name'],
                              ));
                        },
                        child: Container(
                          height: SizeConfig.blockSizeVertical = 60,
                          width: SizeConfig.blockSizeHorizontal = 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.buttonColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: NetworkImage(
                              controller.subCategoryList[index]['image'] ?? '',
                            )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: SizeConfig.blockSizeHorizontal = 70,
                        child: TextLine(
                            title:
                                controller.subCategoryList[index]['name'] ?? '',
                            fontSize: 12,
                            lines: 1,
                            isBold: false)),
                  ],
                ),
              ),
            ),
    );
  }
}
