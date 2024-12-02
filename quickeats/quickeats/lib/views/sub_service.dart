import 'view_list.dart';

class SubService extends StatelessWidget {
  const SubService(
      {super.key, required this.categoryId, required this.categoryName});

  final String categoryId;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: appBarName(name: categoryName),
      body:  Column(
        children: [
         SubCategoryHorizontalWidget(categoryId: categoryId,),
          const SliderWidget(),
        ],
      ),
    );
  }
}
