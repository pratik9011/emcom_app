import 'package:get/get.dart';

import '../widget/favorite_provider_widget.dart';
import 'view_list.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    controller.getFavoriteListApi();
    return  Scaffold(
      appBar: appBarName(name: 'favorite'),
      body: const SingleChildScrollView(
        child: ProviderFavoriteListWidget(),
      ),
    );
  }
}
