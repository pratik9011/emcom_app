import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import 'widgetList.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key, this.autoPlay = false});

  final bool autoPlay;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Obx(
      () => controller.isLoading.isTrue
          ? const SizedBox()
          : SizedBox(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 0.3
                  : MediaQuery.of(context).size.height * 0.3,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: autoPlay,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
                items: controller.sliderMainList.map<Widget>((item) {
                  return Builder(
                    builder: (BuildContext context) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 190.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                item['image'],
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.white,
                          ),
                        ),
                      ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
