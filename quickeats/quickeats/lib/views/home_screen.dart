import 'package:get/get.dart' show Get, Inst;
import 'package:quickeats/config.dart';
import '../widget/product_card_horizantal_widget.dart';
import '../widget/product_section_horizantal.dart';
import 'view_list.dart'
    show
        AppColors,
        BuildContext,
        CategoryHorizontalWidget,
        Column,
        HomeController,
        ProviderWidget,
        Scaffold,
        ServiceWidget,
        SingleChildScrollView,
        SliderWidget,
        StatelessWidget,
        Widget,
        appBarHome;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController()).getHomeApi();
    return Scaffold(
      appBar: appBarHome(),
      backgroundColor: AppColors.white,
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SearchResultHere(),
            CategoryHorizontalWidget(),
            SliderWidget(),
            SizedBox(height: 30,),
            ProductSectionHorizontal(title: 'chosen for you',),
            ProductCardHorizontalWidget(),
            SizedBox(height: 30,),
            ProductSectionHorizontal(title: 'New Arrivals',isShowMore: true,),
            ProductCardHorizontalWidget(),


          ],
        ),
      ),
    );
  }
}
