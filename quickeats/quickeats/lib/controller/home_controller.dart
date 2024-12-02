import 'package:get/get.dart';
import 'package:quickeats/views/search_screen.dart';
import 'controller_list.dart';
import 'package:http/http.dart'as http;

class HomeController extends GetxController {
  var isLoading = true.obs;
  var isSearch = true.obs;
  final categoryList = [].obs;
  final sectionList = [].obs;
  final sliderMainList = [].obs;
  final sliderTopList = [].obs;
  final sliderMiddleList = [].obs;
  final sliderBottomList = [].obs;
  final providerList = [].obs;
  final serviceList = [].obs;
  final searchResultList = [].obs;
  final searchProductList = [].obs;

  // getHomeApi() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? id = pref.getString('user_id');
  //   isLoading.value = true;
  //   final data = await apiServices.postApi(
  //       AppUrl.homeUrl,
  //       {
  //         'user_id': id,
  //       },
  //       isData: true, isToken: true);
  //
  //   if (data.isSuccess == true) {
  //     printTest('success');
  //     categoryList.value = data.data['category'];
  //     sectionList.value = data.data['section'];
  //     sliderMainList.value = data.data['slider_main'];
  //     sliderTopList.value = data.data['slider_top'];
  //     sliderMiddleList.value = data.data['slider_middle'];
  //     sliderBottomList.value = data.data['slider_bottom'];
  //     providerList.value = data.data['provider'];
  //     serviceList.value = data.data['service'];
  //     isLoading.value = false;
  //   } else {
  //     isLoading.value = false;
  //     snackBar(isSuccess: data.isSuccess!, message: data.message);
  //   }
  // }

  getHomeApi() async {
    printTest('success');
    categoryList.value = [
      {
        'id': '1',
        "name": "test",
      },
      {
        'id': '1',
        "name": " Face mask",
      },
      {
        'id': '1',
        "name": "Eye contour products",
      },
      {
        'id': '1',
        "name": "Lip care products",
      },
      {
        'id': '1',
        "name": "Hand care products",
      },
      {
        'id': '1',
        "name": "Foot care products",
      },
    ];

    providerList.value = [
      {
        'id': '',
        'image':
            'https://www.mygirlco.com/writable/uploads/filemanager/source/FCanda/15CMC/CandyYum/1.jpg',
        'name': 'lips',
        'title': 'Loria lips',
        'offer_rate': '\$1200',
        'original_rate': '\$1200',
        'rating': '4.5',
        'rating_count': '805',
      },
      {
        'id': '',
        'image':
            'https://www.mygirlco.com/writable/uploads/filemanager/source/FCanda/15CMC/CandyYum/1.jpg',
        'name': 'lips',
        'title': 'Loria lips',
        'offer_rate': '\$1200',
        'original_rate': '\$1200',
        'rating': '4.5',
        'rating_count': '805',
      },
      {
        'id': '',
        'image':
            'https://www.mygirlco.com/writable/uploads/filemanager/source/FCanda/15CMC/CandyYum/1.jpg',
        'name': 'lips',
        'title': 'Loria lips',
        'offer_rate': '\$1200',
        'original_rate': '\$1200',
        'rating': '4.5',
        'rating_count': '805',
      },
      {
        'id': '',
        'image':
            'https://www.mygirlco.com/writable/uploads/filemanager/source/FCanda/15CMC/CandyYum/1.jpg',
        'name': 'lips',
        'title': 'Loria lips',
        'offer_rate': '\$1200',
        'original_rate': '\$1200',
        'rating': '4.5',
        'rating_count': '805',
      },
    ];
    // sectionList.value = data.data['section'];
    sliderMainList.value = [
      {
        'id': '1',
        'image':
            'https://www.sephora.com/contentimages/FY243785-2024-holiday-site-desktop-universal-navigation-button-value-under-20-us-ca-2950-release.jpg?imwidth=294',
      },
      {
        'id': '1',
        'image':
            'https://www.sephora.com/contentimages/FY243785-2024-holiday-site-desktop-universal-navigation-button-value-under-20-us-ca-2950-release.jpg?imwidth=294',
      },
      {
        'id': '1',
        'image':
            'https://www.sephora.com/contentimages/FY243785-2024-holiday-site-desktop-universal-navigation-button-value-under-20-us-ca-2950-release.jpg?imwidth=294',
      },
      {
        'id': '1',
        'image':
            'https://www.sephora.com/contentimages/FY243785-2024-holiday-site-desktop-universal-navigation-button-value-under-20-us-ca-2950-release.jpg?imwidth=294',
      },
      {
        'id': '1',
        'image':
            'https://www.sephora.com/contentimages/FY243785-2024-holiday-site-desktop-universal-navigation-button-value-under-20-us-ca-2950-release.jpg?imwidth=294',
      },
      {
        'id': '1',
        'image':
            'https://www.sephora.com/contentimages/FY243785-2024-holiday-site-desktop-universal-navigation-button-value-under-20-us-ca-2950-release.jpg?imwidth=294',
      },
    ];

    searchResultList.value =[
      {
        'title':'test Result',
      },
      {
        'title':'test Result',
      }, {
        'title':'test Result',
      }, {
        'title':'test Result',
      }, {
        'title':'test Result',
      }, {
        'title':'test Result',
      }, {
        'title':'test Result',
      }, {
        'title':'test Result',
      }, {
        'title':'test Result',
      },
    ];
    // sliderTopList.value = data.data['slider_top'];
    // sliderMiddleList.value = data.data['slider_middle'];
    // sliderBottomList.value = data.data['slider_bottom'];
    // providerList.value = data.data['provider'];
    // serviceList.value = data.data['service'];
    isLoading.value = false;
  }


  Future<void> searchProduct({required String searchString}) async {
    isLoading.value = false;
    final url = Uri.parse("https://bb2-api.ashwinsrivastava.com/store/product/search?minRating=1&sortBy=$searchString");
    try {
      final response = await http.get(url);
      Map<String, dynamic> res = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        isLoading.value = true;
        isSearch.value = false;
        printTest(isSearch.value);
        searchProductList.value = res['data'];
        Get.offAllNamed('mainPage');
      } else {
        isLoading.value = true;
        isSearch.value = false;
        printTest(isSearch.value);
        Get.offAllNamed('mainPage');
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }
}
