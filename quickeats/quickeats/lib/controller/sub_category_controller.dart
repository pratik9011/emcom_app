import 'package:get/get.dart';

import '../res/components/print.dart';
import 'controller_list.dart';

class SubCategoryController extends GetxController {
  var isLoading = true.obs;
  final subCategoryList = [].obs;

  subCategoryApi({required String categoryId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('user_id');
    isLoading.value = true;
    final data = await apiServices.postApi(
        AppUrl.subCategoryUrl,
        {
          'user_id': id,
          'parent_id': categoryId,
        },
        isData: true,
        isToken: true);

    if (data.isSuccess == true) {
      printTest('success');
      printTest(data.data);
      subCategoryList.value = data.data;

      isLoading.value = false;
    } else {}
  }
}
