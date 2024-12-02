import 'package:get/get.dart';
import 'package:quickeats/config.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(height: 30, width: 220, child: CircularInputField()),
            TextLine(
              title: 'cancel',
              fontSize: 15,
              color: AppColors.blue,
            ),
          ],
        ),
      ),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextLine(
                title: "Search result",
                fontSize: 13,
                isBold: true,
              ),
            ),
            const SearchResultsWidget(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextLine(
                title: "Search result",
                fontSize: 13,
                isBold: true,
              ),
            ),
            const SearchResultsWidget(),
            Obx(() =>controller.isLoading.isTrue? const SizedBox():const Center(
              child: CircularProgressIndicator(),
            ))
          ],
        ),
      ),
    );
  }
}

class CircularInputField extends StatelessWidget {
  const CircularInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    var isActive = true.obs;
    var isLoading = false.obs;
    return Obx(
      () => controller.isLoading.isTrue
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search",
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: isActive.value == true
                      ? const Icon(Icons.cancel)
                      : const SizedBox(),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Circular border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0), // Border color when focused
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0), // Default border color
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0), // Padding inside the field
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                  } else {
                    isActive.value = true;
                  }
                },
                onSubmitted: (value) {
                  controller.searchProduct(searchString: value);
                },
              ),
            ),
    );
  }
}

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => SizedBox(
          width: double.infinity,
          height: 107.0 * controller.searchResultList.length,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.searchResultList.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextLine(
                        title: controller.searchResultList[index]['title'],
                        fontSize: 12),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
