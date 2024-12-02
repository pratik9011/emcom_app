import 'package:get/get.dart';
import 'package:quickeats/config.dart';

import '../../views/search_screen.dart';
import 'components_list.dart'
    show AppBar, AppColors, AssetsImage, BorderRadius, BorderSide, BuildContext, Colors, EdgeInsets, Get, Icon, Icons, Image, InkWell, InputDecoration, MainAxisAlignment, OutlineInputBorder, Padding, Row, SizeConfig, StatelessWidget, Text, TextField, TextLine, VoidCallback, Widget, translate, widthSpaceBox;

dynamic appMain() {
  return AppBar(
    backgroundColor: AppColors.white,
    surfaceTintColor: AppColors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icon/logo_task.png",
          height: 80,
          width: 80,
        ),
      ],
    ),
  );
}

dynamic appBarLeading(
  String name,
) {
  return AppBar(
    toolbarHeight: 40,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    centerTitle: true,
    leading: InkWell(
        onTap: () => Get.offAllNamed('mainPage'),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        )),
    title: TextLine(
        title: translate(name),
        fontSize: 17,
        isBold: true,
        color: AppColors.black),
  );
}

dynamic appBarBack(String name, VoidCallback onTap) {
  return AppBar(
    toolbarHeight: 40,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    centerTitle: true,
    leading: InkWell(
        onTap: () => Get.offAllNamed('mainPage'),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        )),
    title: TextLine(
        title: translate(name),
        fontSize: 17,
        isBold: true,
        color: AppColors.black),
  );
}

dynamic appBarHome() {
  return AppBar(
    backgroundColor: AppColors.white,
    title: Row(
      children: [
        Image.asset(
          AssetsImage.logoBig,
          width: SizeConfig.blockSizeHorizontal = 100,
          height: SizeConfig.blockSizeVertical = 100,
        ),
        const SizedBox(width: 10,),
        InkWell(
          onTap: (){
           Get.to(()=>const SearchScreen());
          },
          child: Container(
            width: 120,
            height: 30,
            decoration:  BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.blackShade1),

            ),
            child:  Row(
              children: [
                widthSpaceBox(size: 10),
                const Icon(Icons.search_rounded),
                const TextLine(title: "search", fontSize: 13,isBold: true,)
              ],
            ),
          ),
        )
      ],
    ),
    actions: [
      const Icon(Icons.favorite_border_outlined),
      widthSpaceBox(size: 20),
       Image.asset('assets/images/shopping-bag.png',width: 20,height: 20,),
      widthSpaceBox(size: 10),
    ],
  );
}

dynamic appBarName({required String name}) {
  return AppBar(
    backgroundColor: AppColors.white,
    title: Text(name),
  );
}



